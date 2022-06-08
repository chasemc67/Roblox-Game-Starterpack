local function deepcopy(table)
    local orig_type = type(table)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, table, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(table)))
    else -- number, string, boolean, etc
        copy = table
    end
    return copy
end

local function deepmerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                deepmerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

local RoduxUtils = {
    ["deepmerge"] = deepmerge,
    ["deepcopy"] = deepcopy
}

return RoduxUtils