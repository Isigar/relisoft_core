Elements = {}

function createMenu(title, name, elements, options)
    options = options or {}

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), name, {
        align = "right",
        elements = elements,
        title = title
    }, function(data, menu)
        if options.submit ~= nil then
            options.submit(data,menu)
        else
            local val = data.current.value
            local action = getElement(val)
            action(menu)
        end
    end, function(data, menu)
        if options.close ~= nil then
            options.close(data,menu)
        else
            menu.close()
        end
    end)
end

exports('createMenu',createMenu)

function createDialog(title, name, onSubmit)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), name, {
        title = title
    }, function(data, menu)
        onSubmit(data,menu)
    end, function(data, menu)
        menu.close()
    end)
end

exports('createDialog',createDialog)

function closeAllMenu()
    ESX.UI.Menu.CloseAll()
end

exports('closeAllMenu',closeAllMenu)

function closeMenu(name)
    ESX.UI.Menu.Close('default',GetCurrentResourceName(),name)
end

exports('closeMenu',closeMenu)

function closeDialog(name)
    ESX.UI.Menu.Close('dialog',GetCurrentResourceName(),name)
end

exports('closeDialog',closeDialog)

function addElement(name, action)
    Elements[name] = action
end

exports('addElement',addElement)

function getElement(name)
    return Elements[name]
end

exports('getElement',getElement)

function removeElement(name)
    Elements[name] = nil
end

exports('removeElement',removeElement)

