local fontId

Citizen.CreateThread(function()
    RegisterFontFile('firesans') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('Fire Sans') -- the name from the .xml
    print(string.format('[rcore] setting up font Fire Sans as ID: %s',fontId))
end)

function getFontId()
    return fontId
end

exports('getFontId',getFontId)