require("Utility/Mocks")

SpellRangeMock = {}
PrepareForMocks(SpellRangeMock)

function SpellRangeMock.CreateMockedMethods()
    MockMethodInstanced(SpellRangeMock, "IsSpellInRange", true)
end

SpellRangeMock.CreateMockedMethods()

return SpellRangeMock