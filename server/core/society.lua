---@param number string
---@param text string
function registerNumber(number, text)
    -- last two parameters do nothing at our esx_gcphone version but keeping it them because its everywhere like that
    TriggerEvent('esx_phone:registerNumber', number, text, true, true)
end

---@param society string Name of society
---@param name string Translated name of society
---@param type string Default is public, can be private
---@return boolean|nil
function registerSociety(society, name, type)
    type = type or "public"
    if not type(society) == "string" or not type(name) == "string" then
        debug('Register of society failed! For register society parameters society, name must be string!')
        return nil
    else
        TriggerEvent('esx_society:registerSociety', society, name, 'society_'..society, 'society_'..society, 'society_'..society, {type = type})
        return true
    end
end

---@param cmd string Name of command without slash
---@param level number Needed admin level
---@param cb function Callback with source,args,user
---@param help string If set it will display at chat helper
function addAdminCmd(cmd, level, cb, help)
    help = help or ""
    TriggerEvent('es:addAdminCommand', cmd, level, function(source, args, user)
        cb(source,args,user)
    end, function(source, args, user)
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Nedostatečné oprávnění!' } })
    end, {help = help})
end

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
---@param help string If set it will display at chat helper
function addCmd(cmd, cb, help)
    help = help or ""
    TriggerEvent('es:addCommand',cmd,function(source, args, user)
        cb(source,args,user)
    end, {help = help})
end
