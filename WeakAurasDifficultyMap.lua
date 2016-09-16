InstanceDifficulty = {}

function InstanceDifficulty.GetFromIndex(difficultyIndex)
    local size, difficulty

    if difficultyIndex == 1 then
        size = "party"
        difficulty = "normal"
    elseif difficultyIndex == 2 then
        size = "party"
        difficulty = "heroic"
    elseif difficultyIndex == 3 then
        size = "ten"
        difficulty = "normal"
    elseif difficultyIndex == 4 then
        size = "twentyfive"
        difficulty = "normal"
    elseif difficultyIndex == 5 then
        size = "ten"
        difficulty = "heroic"
    elseif difficultyIndex == 6 then
        size = "twentyfive"
        difficulty = "heroic"
    elseif difficultyIndex == 7 then
        size = "twentyfive"
        difficulty = "lfr"
    elseif difficultyIndex == 8 then
        size = "party"
        difficulty = "challenge"
    elseif difficultyIndex == 9 then
        size = "fortyman"
        difficulty = "normal"
    elseif difficultyIndex == 11 then
        size = "scenario"
        difficulty = "heroic"
    elseif difficultyIndex == 12 then
        size = "scenario"
        difficulty = "normal"
    elseif difficultyIndex == 14 then
        size = "flexible"
        difficulty = "normal"
    elseif difficultyIndex == 15 then
        size = "flexible"
        difficulty = "heroic"
    elseif difficultyIndex == 16 then
        size = "twenty"
        difficulty = "mythic"
    elseif difficultyIndex == 17 then
        size = "flexible"
        difficulty = "lfr"
    elseif difficultyIndex == 23 then
        size = "party"
        difficulty = "mythic"
    elseif difficultyIndex == 24 then
        size = "party"
        difficulty = "timewalking"
    else
        return nil
    end
end