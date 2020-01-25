Society = {}

--- @param number string
--- @param text string
function registerNumber(number, text)
    -- last two parameters do nothing at our esx_gcphone version but keeping it them because its everywhere like that
    TriggerEvent('esx_phone:registerNumber', number, text, true, true)
end

exports('registerNumber',registerNumber)

--- @param society string Name of society
--- @param name string Translated name of society
--- @param type string Default is public, can be private
--- @return boolean|nil
function registerSociety(society, name, type)
    if Society[society] == nil then
        Society[society] = {
            name = name,
            society = 'society_' .. society,
            job = society
        }
    end
    getSociety(society, function(soc)
        if soc ~= nil then
            rdebug(string.format('Society %s is already registered!',society))
        else
            type = type or "public"
            TriggerEvent('esx_society:registerSociety', society, name, 'society_' .. society, 'society_' .. society, 'society_' .. society, { type = type })
            return true
        end
    end)
end

exports('registerSociety',registerSociety)

function getSociety(society, cb)
    TriggerEvent('esx_society:getSociety',society, function(society)
        cb(society)
    end)
end

exports('getSociety',getSociety)