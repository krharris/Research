local json = require "json"

local textBox = native.newTextBox( 15, 250, 600, 650 )

local baseUrl = "https://api.parse.com/1/classes/"
local objectClass = "TestClass"
local objectId = nil
--local responseTF = nil

local headers = {}
headers["Content-Type"]           = "application/json"
headers["X-Parse-Application-Id"] = "J36djR1sCnTX7NUgHpI4HtdPQwArLw0A26yyvuTz" -- Application-Id
headers["X-Parse-REST-API-Key"]   = "IdYqe1npDzrYyiWzDOTgqN3mBWTJOxvk8TPgEdMB" -- REST-API-Key

local params = {}
params.headers = headers

local function networkListener( event )
        
	if ( event.isError ) then
		print( "Network error!")
	else
	    local response = json.decode ( event.response )
   
	    if response["objectId"] then
	    	objectId = response["objectId"]
	    end
	end
	
	local response = "RESPONSE: " .. event.response 
	print( response )
	textBox.text = textBox.text .. response
	
end

local function post( message )
	params.body = json.encode( message )
    network.request( baseUrl .. objectClass, "POST", networkListener,  params)
end

local function put( message, id )
	
	if id then
		params.body = json.encode( message )
		network.request( baseUrl .. objectClass .."/".. id, "PUT", networkListener,  params)
	end
	
end

local function delete( id )
	
	if id then 
		network.request( baseUrl .. objectClass .."/".. id, "DELETE", networkListener,  params) 
	end
	
    objectId = nil
end

local function get( id )
	
	params.body = nil
	
	if id then 
		network.request( baseUrl .. objectClass .."/".. id, "GET", networkListener,  params)
	end
	
end

-- set up buttons

--responseTF = display.newText ( "", 300, 260, 400, 400, native.systemFont, 24)

local function buttonHandler ( event )

	local method = event.target.method

	if event.phase == "began" then

		if method == "POST (Create)" then

			-- Post to create our new object.
			local message = { foo = "bar" }
			post( message )

	    elseif method == "GET (Return)" then 
		
			-- Get our new object to test wether or not it was created.
			get( objectId )
			
	    elseif method == "PUT (Update)" then 
		
			-- Put to ou rnew objetc to update iot with changes.
			local message = { foo = "baz" }
			put( message, objectId )
			
	    elseif method == "DELETE (Delete)" then
		
			-- Delete our new object.
			delete( objectId )
			
		end

	end

end

local buttons = { "POST (Create)", "GET (Return)", "PUT (Update)", "DELETE (Delete)" }

for i = 1, #buttons do

	local b = display.newText( buttons[i], 30, 50*i, native.systemFontBold, 23)
	b.method = buttons[i]
	b:addEventListener ( "touch", buttonHandler )

end
