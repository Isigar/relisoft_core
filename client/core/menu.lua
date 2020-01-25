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
        menu.close()
    end)
end

exports('createMenu',createMenu)

function closeAllMenu()
    ESX.UI.Menu.CloseAll()
end

exports('closeAllMenu',closeAllMenu)

function closeMenu(name)
    ESX.UI.Menu.Close('default',GetCurrentResourceName,name)
end

exports('closeMenu',closeMenu)

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

