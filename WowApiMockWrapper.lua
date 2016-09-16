
require("Utility/Mocks")

WowApiMock = {}

PrepareForMocks(WowApiMock)

function ResetMocks()
    for index, property in ipairs(WowApiMock.BackingProperties.Values) do
        WowApiMock.BackingProperties.Values[property] = nil
    end

    for key, value in pairs(WowApiMock.ConstantDefaults) do
        _G[key] = value
    end
end

function WowApiMock.MockMethod(methodName, mockedData)
    MockMethodGlobal(methodName, mockedData, WowApiMock)
end

function WowApiMock.MockConstant(constantName, mockedData)
    MockConstantGlobal("MAX_TALENT_TIERS", 6, WowApiMock)
end

function WowApiMock.CreateMockedMethods()
    WowApiMock.MockMethod("GetTalentInfo", "TODO: Mock TalentInfo")
    WowApiMock.MockMethod("GetPvpTalentInfo", "TODO: Mock PvpTalentInfo")
    
    -- Commented lines here indicate that there's something different about these
    -- that needs more attention.
    WowApiMock.MockMethod("IsAddOnLoaded", 1)
    WowApiMock.MockMethod("InCombatLockdown", nil)
    WowApiMock.MockMethod("LoadAddOn", {1, nil})
    WowApiMock.MockMethod("setfenv", "TODO: Mock setfenv")
    WowApiMock.MockMethod("UnitName", "EvilBoss")
    WowApiMock.MockMethod("GetRealmName", "Bonechewer")
    WowApiMock.MockMethod("GetRealZoneText", "Azshara")
    WowApiMock.MockMethod("GetCurrentMapAreaID", 1234)
    WowApiMock.MockMethod("UnitGroupRoleAssigned", "DAMAGE")
    WowApiMock.MockMethod("UnitRace", "Gnome")
    WowApiMock.MockMethod("UnitFactionGroup", "Alliance")
    WowApiMock.MockMethod("IsInRaid", true)
    WowApiMock.MockMethod("UnitClass", {"Mage", "MAGE", 8})
    WowApiMock.MockMethod("UnitExists", 1)
    WowApiMock.MockMethod("UnitGUID", "0xF530007EAC083004")
    WowApiMock.MockMethod("UnitAffectingCombat", 1)
    WowApiMock.MockMethod("GetSpecialization", 1234)
    WowApiMock.MockMethod("GetActiveSpecGroup", 1234)
    WowApiMock.MockMethod("GetInstanceInfo", {"The Emerald Nightmare", "raid", 10, "10-30 Player Heroic", 10, 0, true, 1234, 11})
    WowApiMock.MockMethod("IsInInstance", {true, "raid"})
    WowApiMock.MockMethod("GetNumGroupMembers", 11)
    WowApiMock.MockMethod("UnitIsUnit", true)
    WowApiMock.MockMethod("GetRaidRosterInfo", {"Guildmate", 2, 1, 110, "Mage", "MAGE", "The Emerald Nightmare", 1, nil, "MAINTANK", 1})
    WowApiMock.MockMethod("GetSpecialization", 1)
    WowApiMock.MockMethod("GetSpecializationRole", "TODO: Mock GetSpecializationRole")
    WowApiMock.MockMethod("UnitInVehicle", nil)
    WowApiMock.MockMethod("UnitHasVehicleUI", false)
    WowApiMock.MockMethod("GetSpellInfo", {"Fireball", "Rank 5", "SOME_ICON_PATH", 1500, 0, 40, 1234})
    WowApiMock.MockMethod("SendChatMessage", nil)
    WowApiMock.MockMethod("GetChannelName", {1234, "The Emerald Nightmare - General", 0})
    WowApiMock.MockMethod("UnitInBattleground", 13)
    WowApiMock.MockMethod("UnitInRaid", 1)
    WowApiMock.MockMethod("UnitInParty", 1)
    WowApiMock.MockMethod("PlaySoundFile", nil)
    --WowApiMock.MockMethod("PlaySoundKitID", "TODO: Mock PlaySoundKitID")
    WowApiMock.MockMethod("GetTime", 123456789)
    --WowApiMock.MockMethod("GetSpellLink", "TODO: Mock GetSpellLink")
    --WowApiMock.MockMethod("GetItemInfo", "TODO: Mock GetItemInfo")
    --WowApiMock.MockMethod("CreateFrame", "TODO: Mock CreateFrame")
    WowApiMock.MockMethod("IsShiftKeyDown", nil)
    WowApiMock.MockMethod("GetScreenWidth", 1024)
    WowApiMock.MockMethod("GetScreenHeight", 768)
    WowApiMock.MockMethod("GetCursorPosition", {600, 600})
    --WowApiMock.MockMethod("random", "TODO: Mock random")
    WowApiMock.MockMethod("UpdateAddOnCPUUsage", nil)
    WowApiMock.MockMethod("GetFrameCPUUsage", {100, 20})
    WowApiMock.MockMethod("debugprofilestop", 100)
    WowApiMock.MockMethod("debugstack", "FAKE_DEBUG_STACK")
    WowApiMock.MockMethod("IsSpellKnown", true)
    WowApiMock.MockMethod("GetAddOnEnableState", 2)
    --WowApiMock.MockMethod("IsPlayerMoving", "TODO: Mock IsPlayerMoving")
    WowApiMock.MockMethod("UnitIsDead", nil)

    local addOnMetadataFunc = function(addOnName, metadata)
        if addOnName == "WeakAuras" and metadata == "Version" then
            return "7.0"
        end
    end

    WowApiMock.MockMethod("GetAddOnMetadata", addOnMetadataFunc)

    local classInfoMap = {
        {"Warrior", "WARRIOR", 1},
        {"Paladin", "PALADIN", 2},
        {"Hunter", "HUNTER", 3},
        {"Rogue", "ROGUE", 4},
        {"Priest", "PRIEST", 5},
        {"Death Knight", "DEATHKNIGHT", 6},
        {"Shaman", "SHAMAN", 7},
        {"Mage", "MAGE", 8},
        {"Warlock", "WARLOCK", 9},
        {"Monk", "MONK", 10},
        {"Druid", "DRUID", 11},
        {"Demon Hunter", "DEMONHUNTER", 12}
    }

    local getClassInfoFunc = function(classId)
        return classInfoMap[classId]
    end

    WowApiMock.MockMethod("GetClassInfo", getClassInfoFunc)

    WowApiMock.MockConstant("MAX_TALENT_TIERS", 6)
    WowApiMock.MockConstant("NUM_TALENT_COLUMNS", 3)

    WowApiMock.MockConstant("MAX_PVP_TALENT_TIERS", 6)
    WowApiMock.MockConstant("MAX_PVP_TALENT_COLUMNS", 3)
end

WowApiMock.CreateMockedMethods()

--TESTING When the mocked value is a function, its called appropriately.
local func = function(input) 
    if input == "IsMatch" then 
        return "Success"
    else 
        return "Failure"
    end
end

local talentInfoTemp = "TODO: Mock TalentInfo"
assert(GetTalentInfo("IsMatch") == talentInfoTemp, "FAIL")
assert(GetTalentInfo("IsNotMatch") == talentInfoTemp, "FAIL")


MockGetTalentInfo(func)
assert(GetTalentInfo("IsMatch") == "Success", "FAIL")
assert(GetTalentInfo("IsNotMatch") == "Failure", "FAIL")

--TESTING When the mock has multiple return values, we get them all.
MockLoadAddOn({1,"Successful Load"})
local success, reason = LoadAddOn("WeakAuras2")
assert(success == 1, "FAIL")
assert(reason == "Successful Load")

--TESTING When the mock return nil as one of its multiple return values, we get them all.
MockLoadAddOn({nil,"Failed Load"})
local success, reason = LoadAddOn("WeakAuras2")
assert(success == nil, "FAIL")
assert(reason == "Failed Load")

--TESTING Assigning functions on the wrapper to local variables.
local wrapperFunction = IsShiftKeyDown
MockIsShiftKeyDown(true)
local shiftIsDown = wrapperFunction()
assert(shiftIsDown == true, "FAIL")

--TESTING Reset functionality.
MockIsShiftKeyDown(true)
shiftIsDown = IsShiftKeyDown()
assert(shiftIsDown == true, "FAIL")
ResetMocks()
shiftIsDown = IsShiftKeyDown()
assert(shiftIsDown == nil, "FAIL")

--TESTING Mocking constants works.
local maxTiersOriginal = MAX_TALENT_TIERS
assert(maxTiersOriginal == 6, "FAIL")

MockMAX_TALENT_TIERS(100)
local maxTiersMocked = MAX_TALENT_TIERS
assert(maxTiersMocked == 100, "FAIL")
assert(maxTiersMocked ~= maxTiersOriginal, "FAIL")

ResetMocks()

local resetMaxTiers = MAX_TALENT_TIERS
assert(resetMaxTiers == maxTiersOriginal, "FAIL")

--TESTING When the mock is a function that returns multiple values, the values are unpacked.
local name, filename, id = GetTalentInfo(1)
assert(name == "Warrior", "FAIL")
assert(filename == "WARRIOR", "FAIL")
assert(id == 1, "FAIL")