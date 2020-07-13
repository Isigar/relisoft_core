local societyList = {}
local dbg = rdebug()

--- @param number string
--- @param text string
function registerNumber(number, text)
    -- last two parameters do nothing at our esx_gcphone version but keeping it them because its everywhere like that
    TriggerEvent(EventConfig.Common.phoneRegisterNumber, number, text, true, true)
end

exports('registerNumber',registerNumber)

--- @param society string Name of society
--- @param name string Translated name of society
--- @param type string Default is public, can be private
--- @return boolean|nil
function registerSociety(society, name, type)
    if societyList[society] == nil then
        societyList[society] = {
            name = name,
            society = 'society_' .. society,
            job = society
        }
    end

    type = type or "public"
    TriggerEvent(EventConfig.Society.registerSociety, society, name, 'society_' .. society, 'society_' .. society, 'society_' .. society, { type = type })
    dbg.info(string.format('Society %s is registered!','society_' ..society))
end

exports('registerSociety',registerSociety)

function getSociety(society, cb)
    TriggerEvent(EventConfig.Society.getSociety,society, function(society)
        cb(society)
    end)
end

exports('getSociety',getSociety)
