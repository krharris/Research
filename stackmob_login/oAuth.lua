module(...,package.seeall)
 
local http = require("socket.http")
local ltn12 = require("ltn12")
local crypto = require("crypto")
local mime = require("mime")
--/////////////////////////////////////////////////////////////////////////////////////
--// GET REQUEST TOKEN
--/////////////////////////////////////////////////////////////////////////////////////
function getRequestToken(consumer_key, token_ready_url, request_token_url, consumer_secret)
 
        local post_data = 
        {
                oauth_consumer_key = consumer_key,
                oauth_timestamp    = get_timestamp(),
                oauth_version      = '1.0',
                oauth_nonce        = get_nonce(),
                oauth_callback         = token_ready_url,
                oauth_signature_method = "HMAC-SHA1"
        }
    
    local post_data = oAuthSign(request_token_url, "POST", post_data, consumer_secret)
    
    local result = rawPostRequest(request_token_url, post_data)
    local token = result:match('oauth_token=([^&]+)')
    local token_secret = result:match('oauth_token_secret=([^&]+)')
        
        return 
        {
                token = token,
                token_secret = token_secret
        }
        
end
--/////////////////////////////////////////////////////////////////////////////////////
--// GET ACCESS TOKEN
--/////////////////////////////////////////////////////////////////////////////////////
function getAccessToken(token, verifier, token_secret, consumer_key, consumer_secret, access_token_url)
            
    local post_data = 
        {
                oauth_consumer_key = consumer_key,
                oauth_timestamp    = get_timestamp(),
                oauth_version      = '1.0',
                oauth_nonce        = get_nonce(),
                oauth_token        = token,
                oauth_token_secret = token_secret,
                oauth_verifier     = verifier,
                oauth_signature_method = "HMAC-SHA1"
 
    }
    local post_data = oAuthSign(access_token_url, "POST", post_data, consumer_secret)
    local result = rawPostRequest(access_token_url, post_data)
    return result
end
--/////////////////////////////////////////////////////////////////////////////////////
--// MAKE REQUEST
--/////////////////////////////////////////////////////////////////////////////////////
function makeRequest(url, body, consumer_key, token, consumer_secret, token_secret, method)
    
    local post_data = 
        {
                oauth_consumer_key = consumer_key,
                oauth_nonce        = get_nonce(),
                oauth_signature_method = "HMAC-SHA1",
                oauth_token        = token,
                oauth_timestamp    = get_timestamp(),
                oauth_version      = '1.0',
                oauth_token_secret = token_secret
    }
        for i=1, #body do
                post_data[body[i].key] = body[i].value
        end
    local post_data = oAuthSign(url, method, post_data, consumer_secret)
 
        local result
        
        if method == "POST" then
        result = rawPostRequest(url, post_data)
        else
        result = rawGetRequest(post_data)
        end
        
    return result
end
--/////////////////////////////////////////////////////////////////////////////////////
--// OAUTH SIGN
--/////////////////////////////////////////////////////////////////////////////////////
function oAuthSign(url, method, args, consumer_secret)
 
    local token_secret = args.oauth_token_secret or ""
 
    args.oauth_token_secret = nil
 
        local keys_and_values = {}
 
        for key, val in pairs(args) do
                table.insert(keys_and_values, 
                {
                        key = encode_parameter(key),
                        val = encode_parameter(val)
                })
    end
 
    table.sort(keys_and_values, function(a,b)
        if a.key < b.key then
            return true
        elseif a.key > b.key then
            return false
        else
            return a.val < b.val
        end
    end)
    
    local key_value_pairs = {}
 
    for _, rec in pairs(keys_and_values) do
        table.insert(key_value_pairs, rec.key .. "=" .. rec.val)
    end
    
   local query_string_except_signature = table.concat(key_value_pairs, "&")
   
   local sign_base_string = method .. '&' .. encode_parameter(url) .. '&' .. encode_parameter(query_string_except_signature)
 
   local key = encode_parameter(consumer_secret) .. '&' .. encode_parameter(token_secret)
   local hmac_binary = sha1(sign_base_string, key, true)
 
   local hmac_b64 = mime.b64(hmac_binary)
   local query_string = query_string_except_signature .. '&oauth_signature=' .. encode_parameter(hmac_b64)
 
        if method == "GET" then
           return url .. "?" .. query_string
        else
                return query_string
        end
end
--/////////////////////////////////////////////////////////////////////////////////////
--// ENCODE PARAMETER
--/////////////////////////////////////////////////////////////////////////////////////
function encode_parameter(str)
        return str:gsub('[^-%._~a-zA-Z0-9]',function(c)
                return string.format("%%%02x",c:byte()):upper()
        end)
end
--/////////////////////////////////////////////////////////////////////////////////////
--// SHA 1
--/////////////////////////////////////////////////////////////////////////////////////
function sha1(str,key,binary)
        binary = binary or false
        return crypto.hmac(crypto.sha1,str,key,binary)
end
--/////////////////////////////////////////////////////////////////////////////////////
--// GET NONCE
--/////////////////////////////////////////////////////////////////////////////////////
function get_nonce()
        return mime.b64(crypto.hmac(crypto.sha1,tostring(math.random()) .. "random" .. tostring(os.time()),"keyyyy"))
end
--/////////////////////////////////////////////////////////////////////////////////////
--// GET TIMESTAMP
--/////////////////////////////////////////////////////////////////////////////////////
function get_timestamp()
        return tostring(os.time() + 1)
end
--/////////////////////////////////////////////////////////////////////////////////////
--// RAW GET REQUEST
--/////////////////////////////////////////////////////////////////////////////////////
function rawGetRequest(url)
        local r,c,h
        local response = {}
 
        r,c,h = http.request
        {
                url = url,
                sink = ltn12.sink.table(response)
        }
 
        return table.concat(response,"")
end
--/////////////////////////////////////////////////////////////////////////////////////
--// RAW POST REQUEST
--/////////////////////////////////////////////////////////////////////////////////////
function rawPostRequest(url, rawdata)
 
        local r,c,h
        local response = {}
 
        r,c,h = http.request
        {
                url = url,
                method = "POST",
                headers = 
                {
                        ["Content-Type"] = "application/x-www-form-urlencoded", 
                        ["Content-Length"] = string.len(rawdata)
                },
                source = ltn12.source.string(rawdata),
                sink = ltn12.sink.table(response)
        }
 
        return table.concat(response,"")
end