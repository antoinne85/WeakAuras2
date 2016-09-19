local SpellRangeMock = require("SpellRangeMock")
local BabbleRaceMock = require("BabbleRaceMock")

LibStub = function(libName)
    if libName == "SpellRange-1.0" then
        return SpellRangeMock
    elseif libName == "LibBabble-Race-3.0" then
        return BabbleRaceMock
    -- elseif libName == "LibSharedMedia-3.0" then
    --     return BabbleRaceMock
    end

    error("We haven't mocked the " .. libName .. " library yet.")
end