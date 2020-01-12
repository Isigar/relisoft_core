Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

---@param sourceTable table
---@param targetTable table
---@return table
function mergeTables(sourceTable, targetTable)
    for i, v in pairs(sourceTable) do
        targetTable[i] = v
    end
    return targetTable
end

---@param table table
---@return boolean
function emptyTable(table)
    if next(table) == nil then
        return true
    else
        return false
    end
end

---@param table table
---@return boolean
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

function getConfig()
    return Config
end

---@param func function
---@return boolean
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

function getKeys()
    return Keys
end

---@param table table
---@return number
function tableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

---@param message string
function rdebug(message)
    print('[relisoft_core] '..message)
end

---@param table table
---@return number
function tableLastIterator(table)
    local last = 0
    for i, v in pairs(table) do
        last = i
    end
    return last+1
end

---@return vector3
function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end
