local string = string
local utf8 = utf8

function string.isEmptyOrNil(str)
    return str == nil or str == ""
end

---@param str string
function string.toTable(str)
    --- 字符的第一个字节范围：0x00-0x7F, 0xC2-0xFD. ( 0-127, 194-253 )
    --- 字符的后续字节范围：0x80-0xBF. ( 128-191 )
    --- 字符的第一个字节必须以 0 / 110 / 1110 / 11110 开头，后续字节必须以 10 开头。
    --- 但 0xC0, 0xC1, 0xFE, 0xFF 没有在这里使用，具体可参考：https://zh.wikipedia.org/wiki/UTF-8
    local ret = {}
    -- for _, code in utf8.codes(str) do
    --     ret[#ret + 1] = utf8.char(code)
    -- end
    for char in string.gmatch(str, "[\0-\x7F\xC2-\xFD][\x80-\xBF]*") do
        ret[#ret + 1] = char
    end
    return ret
end
