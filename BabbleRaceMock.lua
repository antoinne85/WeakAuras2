require("Utility/Mocks")

BabbleRaceMock = {}
PrepareForMocks(BabbleRaceMock)

function BabbleRaceMock.CreateMocks()
    -- Setup the lookup table to just return exactly what you asked for.
    -- The mock doesn't translate anything.
    local lookupTable = setmetatable({}, {__index = function(_, inKey)
        return inKey
    end})

    MockMethodInstanced(BabbleRaceMock, "GetLookupTable", lookupTable, false)
end

BabbleRaceMock.CreateMocks()

return BabbleRaceMock