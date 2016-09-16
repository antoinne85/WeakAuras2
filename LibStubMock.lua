local SpellRangeMock = require("SpellRangeMock")

LibStub = function(libName)
    if(libName == "SpellRange-1.0") then
        return SpellRangeMock
    end

    error("We haven't mocked the " .. libName .. "library yet.")
end