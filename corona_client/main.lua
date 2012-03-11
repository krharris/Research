local json = require "json"

local serverAddress = "http://floating-sunset-9026.herokuapp.com"
--local serverAddress = "http://0.0.0.0:3000"

local myText = display.newText("(Waiting for response)", 0, 0, native.systemFont, 16)
myText.x = display.contentCenterX
myText.y = 120

--[[
local function showUser2( event )

	print( "------------------ showUser2 ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )
	end

end
--]]

local function destroySession( event )

	print( "------------------ destroySession ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )
		
		print("")
		
		--network.request( serverAddress .. "/users/show.json?id=50", "GET", showUser2 )
	end

end

local function getChats( event )

	print( "------------------ getChats ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )

		print("")

		local listOfChats = json.decode( event.response )
		
		for i = 1, #listOfChats do
			print( "id = " .. listOfChats[i]["id"] )
			print( "game_id = " .. listOfChats[i]["game_id"] )
			print( "user_id = " .. listOfChats[i]["user_id"] )
			print( "message = " .. listOfChats[i]["message"] )
			print("")
		end

		network.request( serverAddress .. "/sessions/destroy.json", "GET", destroySession )
	end

end

local function getMoves( event )

	print( "------------------ getGames ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )

		print("")

		local listOfMoves = json.decode( event.response )
		
		for i = 1, #listOfMoves do
			print( "id = " .. listOfMoves[i]["id"] )
			print( "game_id = " .. listOfMoves[i]["game_id"] )
			print( "data = " .. listOfMoves[i]["data"] )
			print("")
		end

		network.request( serverAddress .. "/users/chats.json?id=" .. listOfMoves[1]["game_id"], "GET", getChats )
	end

end

local function getGames( event )

	print( "------------------ getGames ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )

		print("")

		local listOfGames = json.decode( event.response )
		
		for i = 1, #listOfGames do
			print( "id = " .. listOfGames[i]["id"] )
			print( "user_id_1 = " .. listOfGames[i]["user_id_1"] )
			print( "user_id_2 = " .. listOfGames[i]["user_id_2"] )
			print( "num_moves = " .. listOfGames[i]["num_moves"] )
			print( "num_chats = " .. listOfGames[i]["num_chats"] )
			print("")
		end

		network.request( serverAddress .. "/users/moves.json?id=" .. listOfGames[1]["id"], "GET", getMoves )
	end

end
--[[
local function showUser( event )

	print( "------------------ showUser ------------------" ) 

	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )
		
		print("")
		
		local userInfo = json.decode( event.response )
		print( "id = " .. userInfo["id"] )
		print( "name = " .. userInfo["name"] )
		print( "email = " .. userInfo["email"] )

		-- OK, we succesfully showed a user, so we know we're logged in.
		-- Now, lets try to get all user's games.
		network.request( serverAddress .. "/users/games.json?id=" .. userInfo["id"], "GET", getGames )
	
	end

end
--]]

local function createSession( event )

	print( "------------------ createSession ------------------" ) 
	
	if ( event.isError ) then
		myText.text = "Network error!"
	else
		myText.text = "See Corona Terminal for response"
		print( event.response )
		
		print("")
		
		local userInfo = json.decode( event.response )
		print( "id = " .. userInfo["id"] )
		print( "name = " .. userInfo["name"] )
		print( "email = " .. userInfo["email"] )
		
		-- OK, we created a session, now lets try to show a user.
		--network.request( serverAddress .. "/users/show.json?id=" .. userInfo["id"], "GET", showUser )
		
		network.request( serverAddress .. "/users/games.json?id=" .. userInfo["id"], "GET", getGames )

	end

end

print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

network.request( serverAddress .. "/sessions/create.json?email=test1@test.com&password=password1", "GET", createSession )




-- local function createSession( event )
-- 
-- 	if ( event.isError ) then
-- 		myText.text = "Network error!"
-- 	else
-- 		myText.text = "See Corona Terminal for response"
-- 		
-- 		print( event.response )
-- 		
-- 		--local listOfUsers = json.decode(event.response)
-- 		--for i = 1, #listOfUsers do
-- 		--	print( listOfUsers[i]["name"] )
-- 		--	print( listOfUsers[i]["email"] )
-- 		--end
-- 
-- 	end
-- 
-- end

--network.request( "http://floating-sunset-9026.herokuapp.com/users/list.json", "GET", networkListener )


-- http://developer.anscamobile.com/node/5305

--[[
postData = "name=Mr Test3&email=test3@test.com&password=testtest&password_confirmation=testtest22"
 
local params = {}
params.body = postData
 
network.request( "http://floating-sunset-9026.herokuapp.com/users/create.json", "POST", networkListener, params)
--]]