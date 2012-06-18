local json = require("json")
local oAuth = require("oAuth")

--local appId = "J36djR1sCnTX7NUgHpI4HtdPQwArLw0A26yyvuTz" -- Application-Id
--local restAPIKey = "IdYqe1npDzrYyiWzDOTgqN3mBWTJOxvk8TPgEdMB" -- REST-API-Key

--local baseUrl = "https://api.parse.com/1/"
local baseUrl = "http://api.mob1.stackmob.com/"
--local baseUrlClasses = "https://api.parse.com/1/classes/"

local objectId = nil
local sessionToken = nil




-- #define STACKMOB_PUBLIC_KEY         @"b532952f-764e-4158-bfad-d30f7866d40f"
-- #define STACKMOB_PRIVATE_KEY        @"2c0f31ba-6705-4475-ae7d-68c44ad75e03"
-- #define STACKMOB_APP_NAME           @"pirate_bones"
-- #define STACKMOB_UDID_SALT          @"828e4a5771d696176b1c6a3e0579858a"
-- #define STACKMOB_APP_DOMAIN         @"stackmob.com"
-- #define STACKMOB_APP_MOB            @"mob1"
-- #define STACKMOB_USER_OBJECT_NAME   @"user"
-- #define STACKMOB_API_VERSION        0


-- local consumer_key = ''
-- local consumer_secret = ''
-- local access_token
-- local access_token_secret
-- local user_id
-- local screen_name
--  
--  
-- local twitter_request = (oAuth.getRequestToken(consumer_key, "your website", "http://twitter.com/oauth/request_token", consumer_secret))
-- local twitter_request_token = twitter_request.token
-- local twitter_request_token_secret = twitter_request.token_secret
--  
-- local function listener(event)
--         
--         local remain_open = true
--         local url = event.url
--         
--         if url:find("oauth_token") then
--                 
--                 url = url:sub(url:find("?") + 1, url:len())
--                 
--                 local authorize_response = responseToTable(url, {"=", "&"})
--                 remain_open = false
--                 
--                 local access_response = responseToTable(oAuth.getAccessToken(authorize_response.oauth_token, authorize_response.oauth_verifier, twitter_request_token_secret, consumer_key, consumer_secret, "https://api.twitter.com/oauth/access_token"), {"=", "&"})
--                 
--                 access_token = access_response.oauth_token
--                 access_token_secret = access_response.oauth_token_secret
--                 user_id = access_response.user_id
--                 screen_name = access_response.screen_name
--                 -- API CALL:
--                 local request_response = oAuth.makeRequest("http://api.twitter.com/1/" .. user_id .. "/lists.json", "", consumer_key, access_token, consumer_secret, access_token_secret, "GET")                
--         end
--  
--         return remain_open
-- end
-- 
-- native.showWebPopup(184, 162, 400, 700, "http://api.twitter.com/oauth/authorize?oauth_token=" .. twitter_request_token, {urlRequest = listener})
--  
--  
-- --/////////////////////////////////////////////////////////////////////////////////////
-- --// RESPONSE TO TABLE
-- --/////////////////////////////////////////////////////////////////////////////////////
-- function responseToTable(str, delimeters)
--         local obj = {}
--         
--         while str:find(delimeters[1]) ~= nil do
--                 if #delimeters > 1 then
--                         local key_index = 1
--                         local val_index = str:find(delimeters[1])
--                         local key = str:sub(key_index, val_index - 1)
--  
--                         str = str:sub((val_index + delimeters[1]:len()))
--  
--                         local end_index
--                         local value
--                 
--                         if str:find(delimeters[2]) == nil then
--                                 end_index = str:len()
--                                 value = str
--                         else
--                                 end_index = str:find(delimeters[2])
--                                 value = str:sub(1, (end_index - 1))
--                                 str = str:sub((end_index + delimeters[2]:len()), str:len())
--                         end
--                         obj[key] = value
--                         --print(key .. ":" .. value)
--                 else
--                         
--                         local val_index = str:find(delimeters[1])
--                         str = str:sub((val_index + delimeters[1]:len()))
--                         
--                         local end_index
--                         local value
--                 
--                         if str:find(delimeters[1]) == nil then
--                                 end_index = str:len()
--                                 value = str
--                         else
--                                 end_index = str:find(delimeters[1])
--                                 value = str:sub(1, (end_index - 1))
--                                 str = str:sub(end_index, str:len())
--                         end
--                         obj[#obj + 1] = value
--                         --print(value)
--                 end
--         end
--         return obj
-- end




local function changeUserDataListener( event )

	if( event.isError ) then
		print( "Network error!")
	else
	    local response = json.decode ( event.response )
	end

	print( event.response )

end

local function changeUserData()

	local headers = {}
	headers["Content-Type"]           = "application/json"
	headers["X-Parse-Application-Id"] = appId
	headers["X-Parse-REST-API-Key"]   = restAPIKey
	headers["X-Parse-Session-Token"]  = sessionToken

	local params = {}
	params.headers = headers

	local message = 
	{ 
		someData = "My Test Data!"
	}

	params.body = json.encode( message )
    network.request( baseUrl .. "users/" .. objectId, "PUT", changeUserDataListener,  params)

end

local function loginUserListener( event )

	if( event.isError ) then
		print( "Network error!")
	else
	    local response = json.decode ( event.response )

	    if response["objectId"] then
	    	objectId = response["objectId"]
	    end

		if response["sessionToken"] then
	    	sessionToken = response["sessionToken"]
	    end
	
		changeUserData()
	end

	print( event.response )

end

local function loginUser()

	local headers = {}
	headers["Content-Type"]           = "application/x-www-form-urlencoded"
	headers["X-Parse-Application-Id"] = appId
	headers["X-Parse-REST-API-Key"]   = restAPIKey

	local params = {}
	params.headers = headers
	params.body = nil

	local username = "Bob"
	local password = "password"

	local URL = baseUrl .. "login?username=" .. username.. "&password=" .. password
	network.request( URL, "GET", loginUserListener,  params)

end

local function registerUserListener( event )

	if( event.isError ) then
		print( "Network error!")
	else
	    local response = json.decode ( event.response )

		-- 	    if response["objectId"] then
		-- 	    	objectId = response["objectId"]
		-- 	    end
		-- 
		-- if response["sessionToken"] then
		-- 	    	sessionToken = response["sessionToken"]
		-- 	    end
	end

	print( event.response )

end

local function registerUser()

	local headers = {}
	headers["Content-Type"] = "application/json"
	headers["Accept"]       = "application/vnd.stackmob+json; version=0"

	--headers["X-Parse-Application-Id"] = appId
	--headers["X-Parse-REST-API-Key"]   = restAPIKey

	local params = {}
	params.headers = headers

	local message = 
	{
		content = "Hello from Lua!",
		views = 25
	}

	params.body = json.encode( message )
    network.request( baseUrl .. "/user", "POST", registerUserListener,  params)

end

registerUser()
--loginUser()
