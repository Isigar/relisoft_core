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

function closeAllMenu()
    ESX.UI.Menu.CloseAll()
end

function closeMenu(name)
    ESX.UI.Menu.Close('default',GetCurrentResourceName,name)
end

function createList()

end

function createTable()

end

function addElement(name, action)
    Elements[name] = action
end

function getElement(name)
    return Elements[name]
end

function removeElement(name)
    Elements[name] = nil
end

