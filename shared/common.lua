-- Stolen from: https://rosettacode.org/wiki/Strip_control_codes_and_extended_characters_from_a_string
function normalizeString( str )

    local s = ""
    for i = 1, str:len() do
        if str:byte(i) >= 32 and str:byte(i) <= 126 then
            s = s .. str:sub(i,i)
        end
    end
    return s

end

exports('normalizeString',normalizeString)

-- Stolen from: https://forums.coronalabs.com/topic/43048-remove-special-characters-from-string/
function urlencode(str)
    if (str) then
        str = string.gsub (str, "\n", "\r\n")
        str = string.gsub (str, "([^%w ])",
            function() return string.format ("%%%02X", string.byte) end)
        str = string.gsub (str, " ", "+")
    end
    return str
end

exports('urlencode',urlencode)