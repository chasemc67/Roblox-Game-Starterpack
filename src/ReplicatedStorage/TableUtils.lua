local function map(table, mapFunction)
    local newArr = {}
    local arrI = 0
    for key, value in pairs(table) do
        newArr[arrI] = mapFunction(key, value)
        arrI = arrI + 1
    end

    return newArr
end

local tableUtils = {
    ["map"] = map
}

return tableUtils