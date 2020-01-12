function createMenu(title, name, elements, options)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), name, {
        align = "right",
        elements = elements,
        title = title
    }, function(data, menu)
        if options.submit ~= nil then
            options.submit(data.current,menu)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function closeAllMenu()
    local esx
    ESX.UI.Menu.CloseAll()
end

function createList()

end

function createTable()

end