---@class Bits Hold 64 Bits
local Bits = class("Bits")

local ZERO = 0x00
local ONE = 0x01

function Bits:init()
    self._bits = ZERO
end

function Bits:Copy()
    local ret = Bits.new()
    ret._bits = self._bits
    return ret
end

---@param index number Start from 1
function Bits:Get(index)
    index = index - 1
    return ((self._bits & (ONE << index)) >> index) == 1
end

---@param index number Start from 1
function Bits:Set(index)
    index = index - 1
    self._bits = self._bits | (ONE << index)
end

---@param index number Start from 1
function Bits:Clear(index)
    index = index - 1
    self._bits = self._bits & (~(ONE << index))
end


local Hex2Bin = {
    ['0'] = '0000',
    ['1'] = '1000',
    ['2'] = '0100',
    ['3'] = '1100',
    ['4'] = '0010',
    ['5'] = '1010',
    ['6'] = '0110',
    ['7'] = '1110',
    ['8'] = '0001',
    ['9'] = '1001',
    ['A'] = '0101',
    ['B'] = '1101',
    ['C'] = '0011',
    ['D'] = '1011',
    ['E'] = '0111',
    ['F'] = '1111'
}

local string_sub = string.sub
local table_insert = table.insert

function Bits.__tostring(bits)
    local hex = string.format("%016X", bits._bits)
    local ret = {}
    for i = 1, 16 do
        local c = string_sub(hex, i, i)
        table_insert(ret, Hex2Bin[c])
    end
    return string.reverse(table.concat(ret))
end

function Bits:ToHex()
    return string.format("%016X", self._bits)
end

return Bits
