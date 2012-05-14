local json = require("json")

local appId = "J36djR1sCnTX7NUgHpI4HtdPQwArLw0A26yyvuTz" -- Application-Id
local restAPIKey = "IdYqe1npDzrYyiWzDOTgqN3mBWTJOxvk8TPgEdMB" -- REST-API-Key

local baseUrl = "https://api.parse.com/1/"
--local baseUrlClasses = "https://api.parse.com/1/classes/"

local objectId = nil
local sessionToken = nil

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

	    if response["objectId"] then
	    	objectId = response["objectId"]
	    end

		if response["sessionToken"] then
	    	sessionToken = response["sessionToken"]
	    end
	end

	print( event.response )

end

local function registerUser()
        
	local headers = {}
	headers["Content-Type"]           = "application/json"
	headers["X-Parse-Application-Id"] = appId
	headers["X-Parse-REST-API-Key"]   = restAPIKey

	local params = {}
	params.headers = headers

	local message = 
	{
		username = "Bob",
		password = "password",
		someData = "My Data!"
	}

	params.body = json.encode( message )
    network.request( baseUrl .. "/users", "POST", registerUserListener,  params)

end

--registerUser()
loginUser()
