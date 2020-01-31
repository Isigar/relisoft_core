local fontId

Citizen.CreateThread(function()
    RegisterFontFile('out') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('Fira Sans') -- the name from the .xml
    print(string.format('[rcore] setting up font Lato as ID: %s',fontId))
    while true do
        Wait(0)
        SetTextFont(fontId)
        BeginTextCommandDisplayText('STRING')
        AddTextComponentString('Hello, world!')
        EndTextCommandDisplayText(0.5, 0.5)
    end
end)

function getFontId()
    return fontId
end

exports('getFontId',getFontId)