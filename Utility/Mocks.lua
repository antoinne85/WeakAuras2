function PrepareForMocks(instance)
    instance.MockedMethods = {}
    instance.BackingProperties = {}
    instance.BackingProperties.Values = {}
    instance.MockedConstants = {}
    instance.ConstantDefaults = {}
end

PrepareForMocks(_G)

--- Stubs out a mocked method.
-- Prepares the API Wrapper simulate a scenario you want to test.
--[[-- @param propertyName The name of the property you want to mock. 
For instance, if you want to mock the method GetRealmName, set this to "RealmName".]]
--[[-- @param getMethodName The name of the method you want to use for actually calling the function.
This should be the same name that the WoW API uses.]]
--[[-- @param setMethodName The name of the method you want to use to set the value for the mock.]]
--[[-- @param defaultValue The value you want the method to return. 
If you specify a literal (like "Bonechewer") GetRealmName would always return Bonechewer. 
If you specify a function, then the function will be called whenever someone calls that function on the API. 
Your function will be passed all of the values that the WoW API would have been passed.]]
function MockMethodFullGlobal(propertyName, getMethodName, setMethodName, defaultValue, dataStore, shouldUnpackResult)
    table.insert(dataStore.BackingProperties.Values, propertyName)
    table.insert(dataStore.MockedMethods, getMethodName)

    _G[getMethodName] = function(...)
        local realParameters = select(1, ...)
        -- The method being mocked may or may not have parameters
        -- so ... to grab them all.

        -- Grab the value we applied to this method on the mock.
        local returnValue = dataStore.BackingProperties.Values[propertyName] or defaultValue; 

        -- If that value is a function, call it with whatever parameters
        -- we were given.
        if type(returnValue) == 'function' then
            local functionReturnValue = returnValue(realParameters)

            if shouldUnpackResult and functionReturnValue ~= nil then
                return table.unpack(functionReturnValue)
            else
                return functionReturnValue
            end
        elseif type(returnValue) == 'table' then
            return table.unpack(returnValue)
        end

        -- Otherwise it must be a constant, just send it back as-is.
        return returnValue
    end

    _G[setMethodName] = function(value)
        dataStore.BackingProperties.Values[propertyName] = value
    end
end

function MockMethodFullInstanced(instance, propertyName, getMethodName, setMethodName, defaultValue, shouldUnpackResult)
    if shouldUnpackResult == nil then
        shouldUnpackResult = true
    end
    
    table.insert(instance.BackingProperties.Values, propertyName)
    table.insert(instance.MockedMethods, getMethodName)

    instance[getMethodName] = function(...)
        local realParameters = select(2, ...)
        -- The method being mocked may or may not have parameters
        -- so ... to grab them all.

        -- Grab the value we applied to this method on the mock.
        local returnValue = instance.BackingProperties.Values[propertyName] or defaultValue; 

        -- If that value is a function, call it with whatever parameters
        -- we were given.
        if type(returnValue) == 'function' then
            local functionReturnValue = returnValue(realParameters)

            if type(functionReturnValue) == 'table' then
                if shouldUnpackResult and functionReturnValue ~= nil then
                    return table.unpack(functionReturnValue)
                else
                    return functionReturnValue
                end
            end
            
            return functionReturnValue
        elseif type(returnValue) == 'table' then
            if shouldUnpackResult and returnValue ~= nil then
                return table.unpack(returnValue)
            else
                return returnValue
            end
        end

        -- Otherwise it must be a constant, just send it back as-is.
        return returnValue
    end

    instance[setMethodName] = function(value)
        instance.BackingProperties.Values[propertyName] = value
    end
end

--- Stubs out a mocked method.
-- Prepares the API Wrapper simulate a scenario you want to test.
--[[-- @param methodName The name of the method you want to mock. 
For instance, if you want to mock the method GetRealmName, set this to "GetRealmName".]]
--[[-- @param defaultValue The value you want the method to return. 
If you specify a literal (like "Bonechewer") GetRealmName would always return Bonechewer. 
If you specify a function, then the function will be called whenever someone calls that function on the API. 
Your function will be passed all of the values that the WoW API would have been passed.]]
function MockMethodGlobal(methodName, defaultValue, dataStore, shouldUnpackResult)
    local setMethodName = "Mock"..methodName
    local propertyName = methodName.."BackingProperty"

    MockMethodFullGlobal(propertyName, methodName, setMethodName, defaultValue, dataStore, shouldUnpackResult)
end

function MockMethodInstanced(instance, methodName, defaultValue, shouldUnpackResult)
    local setMethodName = "Mock"..methodName
    local propertyName = methodName.."BackingProperty"

    MockMethodFullInstanced(instance, propertyName, methodName, setMethodName, defaultValue, shouldUnpackResult)
end

function MockConstantInstanced(instance, constantName, defaultValue)
    instance[constantName] = defaultValue
    instance.ConstantDefaults[constantName] = defaultValue

    local setMethodName = "Mock"..constantName
    instance[setMethodName] = function(mockValue)
        instance[constantName] = mockValue
    end
    table.insert(instance.MockedConstants, constantName)
end

function MockConstantGlobal(constantName, defaultValue, dataStore)
    _G[constantName] = defaultValue
    dataStore.ConstantDefaults[constantName] = defaultValue

    local setMethodName = "Mock"..constantName
    _G[setMethodName] = function(mockValue)
        _G[constantName] = mockValue
    end
    table.insert(dataStore.MockedConstants, constantName)
end