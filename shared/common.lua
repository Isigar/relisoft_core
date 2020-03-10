-- Stolen from: https://rosettacode.org/wiki/Strip_control_codes_and_extended_characters_from_a_string
function normalizeString( str )

    local s = ""
    for i = 1, str:len() do
        if str:byte(i) >= 32 and str:byte(i) <= 126 then
            s = s .. str:sub(i,i)
        end
    end
    return s

end

exports('normalizeString',normalizeString)

-- Stolen from: https://forums.coronalabs.com/topic/43048-remove-special-characters-from-string/
function urlencode(str)
    if (str) then
        str = string.gsub (str, "\n", "\r\n")
        str = string.gsub (str, "([^%w ])",
            function() return string.format ("%%%02X", string.byte) end)
        str = string.gsub (str, " ", "+")
    end
    return str
end

exports('urlencode',urlencode)


--- @param object object
--- stolen: https://forums.coronalabs.com/topic/27482-copy-not-direct-reference-of-table/
function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--- @param sourceTable table
--- @param targetTable table
--- @return table
--- stolen: https://stackoverflow.com/questions/1283388/lua-merge-tables
function mergeTables(t1, t2)
    local target = deepCopy(t1)
    local source = deepCopy(t2)
    for k, v in pairs(source) do
        if (type(v) == "table") and (type(target[k] or false) == "table") then
            mergeTables(target[k], source[k])
        else
            target[k] = v
        end
    end
    return target
end

exports('mergeTables', mergeTables)

--- @param table table
--- @return boolean
function emptyTable(table)
    if isTable(table) then
        if next(table) == nil then
            return true
        else
            return false
        end
    else
        return true
    end
end

exports('emptyTable', emptyTable)

--- @param table table
--- @return boolean
function isTable(table)
    if table ~= nil then
        if type(table) == "table" then
            return true
        end
        return false
    else
        return false
    end
end

exports('isTable', isTable)

--- @param func function
--- @return boolean
function isFunction(func)
    if table ~= nil then
        if type(func) == "function" then
            return true
        end
        return false
    else
        return false
    end
end

exports('isFunction', isFunction)

function getKeys()
    return Keys
end

exports('getKeys', getKeys)

--- @param table table
--- @return number
function tableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

exports('tableLength', tableLength)

--- @param table table
--- @return number
function tableLastIterator(table)
    local last = 0
    for i, v in pairs(table) do
        last = i
    end
    return last
end

exports('tableLastIterator', tableLastIterator)

function getConfig()
    return Config
end

exports('getConfig',getConfig)