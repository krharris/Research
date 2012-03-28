--==============================================================================
-- File:     printTable.lua
-- Author:   Kevin Harris
-- Modified: August 16, 2010
-- Descript: Implementation of PrintTable and the utility function GetVarName.
--==============================================================================

--==============================================================================
-- Function: getVarName( var )
-- Author:   Kevin Harris
-- Modified: August 16, 2010
-- Returns:  Name of variable passed.
-- Descript: Scans the global environment for a particular variable and returns
--           its name. Typically used on tables and functions where getting the
--           name is much harder.
--==============================================================================
function getVarName( var )

    for key, value in pairs( getfenv(0) ) do

        if value == var then

            return tostring( key )

        end

    end

    return "Unknown_Variable_Name"

end

--==============================================================================
-- Function: printTable( tbl (table), indentDepth (number) )
-- Author:   Kevin Harris
-- Modified: August 16, 2010
-- Returns:  nothing
-- Descript: Prints a table and all sub-tables of the table.
--==============================================================================
function printTable( tbl, indentDepth )

    if tbl == nil then

        print( "Error calling printTable() - nil value passed for argument 'tbl'!" )
        return

    end

    if type( tbl ) ~= "table" then

        print( "Error calling printTable() - Must pass a table for argument 'tbl'!" )
        return

    end

    if indentDepth == nil then

        indentDepth = 0

    else
        
        if type( indentDepth ) ~= "number" then

            print( "Error calling printTable() - Must pass a number for argument 'indentDepth'!" )

            return
            
        end

    end

    -- If the depth is not specified - it must be the root table and we
    -- we need to manually print its name and beginning curly brace.
    -- It can't rely on recursion.
    if indentDepth == 0 then

        local varName = getVarName( tbl )

        if varName ~= nil then
            print( varName .. " =\n{" )
        else
            print( "unnamedTable =\n{" )
        end

    end

    for key, value in pairs( tbl ) do

        if indentDepth == 0 then
            depth = 1
        else
            depth = indentDepth
        end

        if type( value ) ~= "table" then

            indentStr = string.rep( "    ", depth )

            -- If the key is a number, the value had no key in the actual
            -- table, so we don't need to print the key name or the equal sign.
            local tempKey
            local keyAsNumber = tonumber( key )

            if keyAsNumber ~= nil then
                tempKey = ""
            else
                tempKey = key .. " = "
            end

            if type( value ) == "string" then

                -- Add quotes to strings.
                tempStr = indentStr .. tempKey .. "\"" .. tostring( value ) .. "\","

            elseif type( value ) == "function" then

                -- Don't print function addresses - print the actual name.
                tempStr = indentStr .. tempKey .. getVarName( value ) .. ","

            else

                tempStr = indentStr .. tempKey .. tostring( value ) .. ","

            end

            print( tempStr )

        elseif type( value ) == "table" then

            -- Print table name and pair it to a beginning curly brace.
            indentStr = string.rep( "    ", depth )

            -- If the table is unnamed, don't print out the index.
            -- Instead, leave it name-less but drop a comment making note of it.
            if type( key ) ~= "number" then

                print( "\n" .. indentStr .. key .. " =" )
                
            else
            
                print( "\n" .. indentStr .. "-- Unnamed table at index [" .. key .. "]" )

            end

            print( indentStr .. "{" )

            -- Increase depth and then go recursive...
            depth = depth + 1

            printTable( value, depth )

        end

    end

    -- If the depth is not specified - it must be the root table and the
    -- last thing we need to do before returning is to close out the last
    -- and final curly brace. It can't rely on recursion like sub-tables.
    if indentDepth == 0 then

        print( "}\n" )

    else

        -- Close out the table by printing the closing curly brace.
        indentStr = string.rep( "    ", indentDepth-1 )
        print( indentStr .. "},\n" )

    end

end
