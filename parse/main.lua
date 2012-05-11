local json = require "json"

local baseUrl = "https://api.parse.com/1/classes/"
local objectClass = "TestClass"
local objectId = nil

local responseTF = nil

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
	
	responseTF.text = "RESPONSE: " .. event.response
	
end

local function post( message )
	params.body = json.encode ( message )
    network.request( baseUrl .. objectClass, "POST", networkListener,  params)
end

local function put( message, id )
	
	if id then
		params.body = json.encode ( message )
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
local message = { foo = "bar" }
responseTF = display.newText ( "", 300, 260, 400, 400, native.systemFont, 24)

local function buttonHandler ( event )

	local method = event.target.method

	if event.phase == "began" then

		if method == "POST" then 
			post( message )
	    elseif method == "GET" then 
			get( objectId )
	    elseif method == "PUT" then 
			put( message, objectId )
	    elseif method == "DELETE" then
			delete( objectId )
		end

	end

end

local buttons = { "POST", "GET", "PUT", "DELETE" }

for i = 1, #buttons do
	
	local b = display.newText( buttons[i], 30, 50*i, native.systemFontBold, 23)
	b.method = buttons[i]
	b:addEventListener ( "touch", buttonHandler )
	
end

-- local Parse = require("parse")
-- 
-- local function main()
-- 	
-- 
-- local function fieldHandler( event )
--         
--         if ( "began" == event.phase ) then
-- 		print ("Began")
-- 		
--                 -- This is the "keyboard has appeared" event
--                 -- In some cases you may want to adjust the interface when the keyboard appears.
--         
--         elseif ( "ended" == event.phase ) then
--                 -- This event is called when the user stops editing a field: for example, when they touch a different field
-- 		print ("Ended")
--         
--         elseif ( "submitted" == event.phase ) then
--                 -- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
--                   
--                 print( "TextField Object is: " .. tostring( event.target.text ) )
-- 
-- 				if (event.target.name == "nameField") then
-- 					Parse.AccountSetup.username = nameField.text
-- 					  if (not nameField.text:match("[^A-Za-z0-9]")) then
-- 						print ("Writing:" .. nameField.text)
-- 					  --write username to DocumentsDirectory, overwriting previous files
-- 					  local path = system.pathForFile( "usr.txt", system.DocumentsDirectory ) 
-- 	                  local file = io.open( path, "w" ) 
-- 		              file:write(event.target.text)
-- 	                  io.close( file )
-- 					  else
-- 					  print("Name format error")
-- 					  end
-- 				elseif (event.target.name == "passwordField") then
-- 					Parse.AccountSetup.password = passwordField.text
-- 					
-- 				elseif (event.target.name == "emailField") then
-- 					--check for email address formatting
-- 					if (event.target.text:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then	
-- 					Parse.AccountSetup.email = emailField.text
-- 					else
-- 					print ("Email format error")
-- 					end
-- 				
-- 				elseif (event.target.name == "updateField") then
-- 						Parse.updateData["credits"] = tonumber(updateField.text)
-- 						print ("updateData: ", Parse.updateData["credits"])
-- 					
-- 				end
-- 					
--                   -- Hide keyboard
--                   native.setKeyboardFocus( nil )
-- 				
-- 				--copy login info to LocalAccount
-- 				if (Parse.AccountSetup.username and Parse.AccountSetup.password and Parse.AccountSetup.email) then
-- 				Parse.LocalAccount.username = Parse.AccountSetup.username
-- 				Parse.LocalAccount.password = Parse.AccountSetup.password
-- 				Parse.LocalAccount.email = Parse.AccountSetup.email
-- 				end
--         end
--   
--         return true
--  
-- end     
-- 
-- 
--     local nameLabel = display.newText ( "Name:", 10, 292, native.systemFontBold, 12)
--     local passwordLabel = display.newText ( "Password:", 10, 332, native.systemFontBold, 12)
--     local emailLabel = display.newText ( "Email:", 10, 372, native.systemFontBold, 12)
-- 	local updateLabel = display.newText ( "Update:", 10, 412, native.systemFontBold, 12)
--  
--     nameField = native.newTextField( 80, 280, 180, 30)
--     nameField:addEventListener("userInput", fieldHandler)
--     nameField.inputType = "default"
--     nameField.name = "nameField"
-- 
--    	passwordField = native.newTextField( 80, 320, 180, 30)
--     passwordField:addEventListener("userInput", fieldHandler)
--     passwordField.inputType = "default"
-- 	passwordField.isSecure = true
-- 	passwordField.name = "passwordField"
-- 
--    	emailField = native.newTextField( 80, 360, 180, 30)
--     emailField:addEventListener("userInput", fieldHandler)
--     emailField.inputType = "email"
-- 	emailField.name = "emailField"
-- 	
-- 	updateField = native.newTextField( 80, 400, 180, 30)
--     updateField:addEventListener("userInput", fieldHandler)
--     updateField.inputType = "update"
-- 	updateField.name = "updateField"
-- 
-- 
-- 
-- 
-- 
-- 
-- end
-- 
-- main()