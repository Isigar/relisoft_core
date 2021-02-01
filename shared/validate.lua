--Validation of data
--rcore.cz
--https://discord.gg/F28PfsY
--Supported checks

local boolRelatives = {
    ['true'] = true,
    ['false'] = false,
    ['1'] = true,
    ['0'] = false,
}

SPLIT_TERM = '|'
PARAM_TERM = ':'

STRUCT_RULE = 'rule'
STRUCT_RULE_PARAMS = 'params'

--Cannot be empty/nil
RULE_REQUIRED = 'required'
--Is type string
RULE_STRING = 'string'
--Is type string
RULE_VECTOR4 = 'vector4'
--Is type string
RULE_VECTOR3 = 'vector3'
--Is type string
RULE_VECTOR2 = 'vector2'
--Is type table
RULE_TABLE = 'table'
--Is type bool (if 0/1, string true,false it convert to bool)
RULE_BOOL = 'bool'
--Check if string has @ in it
RULE_EMAIL = 'email'
--Min count of characters
RULE_MIN = 'min'
--Max count of characters
RULE_MAX = 'max'
--Min value of integer
RULE_INTMIN = 'intMin'
--Max value of integer
RULE_INTMAX = 'intMax'
--Number
RULE_NUMBER = 'number'

local ruleTable = {
    [RULE_REQUIRED] = true,
    [RULE_STRING] = true,
    [RULE_EMAIL] = true,
    [RULE_TABLE] = true,
    [RULE_BOOL] = true,
    [RULE_MIN] = true,
    [RULE_MAX] = true,
    [RULE_INTMIN] = true,
    [RULE_INTMAX] = true,
    [RULE_VECTOR2] = true,
    [RULE_VECTOR3] = true,
    [RULE_VECTOR4] = true,
    [RULE_NUMBER] = true,
}

local ruleTranslateTable = {
    ['required'] = RULE_REQUIRED,
    ['string'] = RULE_STRING,
    ['email'] = RULE_EMAIL,
    ['table'] = RULE_TABLE,
    ['bool'] = RULE_BOOL,
    ['min'] = RULE_MIN,
    ['max'] = RULE_MAX,
    ['intMin'] = RULE_INTMIN,
    ['intMax'] = RULE_INTMAX,
    ['vector3'] = RULE_VECTOR3,
    ['vector2'] = RULE_VECTOR2,
    ['vector4'] = RULE_VECTOR4,
    ['number'] = RULE_NUMBER,
}

--Parse function
--min:256|max:512
local function parse(str)
    local rules = {}
    for rule in string.gmatch(str, "([^"..SPLIT_TERM.."]+)") do
        local rulesParams = {}
        if string.find(rule, PARAM_TERM) then
            for params in string.gmatch(rule, "([^"..PARAM_TERM.."]+)") do
                if ruleTranslateTable[params] == nil then
                    table.insert(rulesParams, params)
                    rule = string.gsub(rule, PARAM_TERM..params, '')
                end
            end
        end
        table.insert(rules, {
            [STRUCT_RULE] = rule,
            [STRUCT_RULE_PARAMS] = rulesParams
        })
    end

    return rules
end

local function applyRule(value, ruleData)
    local rule = ruleData[STRUCT_RULE]
    local params = ruleData[STRUCT_RULE_PARAMS]
    if rule == RULE_REQUIRED then
        if value == nil or value == '' then
            return false, RULE_REQUIRED, params[1] or nil
        end
    elseif rule == RULE_STRING then
        if type(value) ~= 'string' then
            return false, RULE_STRING, params[1] or nil
        end
    elseif rule == RULE_VECTOR2 then
        if type(value) ~= 'vector2' then
            return false, RULE_VECTOR2, params[1] or nil
        end
    elseif rule == RULE_VECTOR3 then
        if type(value) ~= 'vector3' then
            return false, RULE_VECTOR3, params[1] or nil
        end
    elseif rule == RULE_VECTOR4 then
        if type(value) ~= 'vector4' then
            return false, RULE_VECTOR4, params[1] or nil
        end
    elseif rule == RULE_TABLE then
        if type(value) ~= 'table' then
            return false, RULE_TABLE, params[1] or nil
        end
    elseif rule == RULE_BOOl then
        local valueString = tostring(value)

        if boolRelatives[string.lower(valueString)] == nil then
            return false, RULE_BOOL, params[1] or nil
        end
    elseif rule == RULE_EMAIL then
        print(exports.rcore:dumpTable(params))
        if string.match(tostring(value), '@') == nil then
            return false, RULE_EMAIL, params[1] or nil
        end
    elseif rule == RULE_MIN then
        local count = tonumber(params[1])
        if string.len(tostring(value)) < count then
            return false, RULE_MIN, params[2] or nil
        end
    elseif rule == RULE_MAX then
        local count = tonumber(params[1])
        if string.len(tostring(value)) > count then
            return false, RULE_MAX, params[2] or nil
        end
    end

    return true
end

--Example
--local rules = {
--    ['required|string'] = 'some value'
--}
function validate(data)
    if type(data) ~= 'table' then
        print('[VALIDATE ERROR] Validation data must be in type table')
        return false
    end

    for rule,v in pairs(data) do
        local parseRule = parse(rule)
        for _,params in pairs(parseRule) do
            local ok, rl, error = applyRule(v, params)
            if ok == false then
                return false, rl, error
            end
        end
    end
    return true
end
