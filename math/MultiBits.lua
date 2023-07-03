local ipairs = ipairs

---@class MultiBits
local MultiBits = class("MultiBits")

--- an integer can hold 64 bits
---------------------------------------
-- | idx 1 |  idx 2  |  idx 3   | ...
-- | 64<-0 | 128<-65 | 192<-129 | ...
---------------------------------------

local UNIT_LENGTH = 64
local ZERO = 0x00
local ONE = 0x01

local function getUnitIndex(index)
    return index // UNIT_LENGTH + (index % UNIT_LENGTH == 0 and 0 or 1)
end

local function getUnitOffset(index)
    local offset = index % UNIT_LENGTH
    return offset == 0 and UNIT_LENGTH or offset
end

---@param length number
function MultiBits:init(length)
    assert(length > 0, "length must be positive.")
    self.length = length
    self.unitCount = getUnitIndex(length)

    self._units = {}
    for i = 1, self.unitCount do
        self._units[i] = ZERO
    end
end

function MultiBits:Copy()
    local ret = MultiBits.new(self.length)
    for i, v in ipairs(self._units) do
        ret._units[i] = v
    end
    return ret
end

function MultiBits:Get(index)
    index = index - 1
    local unitIndex = getUnitIndex(index)
    local unitOffset = getUnitOffset(index)

    local unit = self._units[unitIndex]
    return ((unit & (ONE << unitOffset)) >> unitOffset) == 1
end

function MultiBits:Set(index)
    index = index - 1
    local unitIndex = getUnitIndex(index)
    local unitOffset = getUnitOffset(index)

    local unit = self._units[unitIndex]
    unit = unit | (ONE << unitOffset)
    self._units[unitIndex] = unit
end

function MultiBits:Clear(index)
    index = index - 1
    local unitIndex = getUnitIndex(index)
    local unitOffset = getUnitOffset(index)

    local unit = self._units[unitIndex]
    unit = unit & (~(ONE << unitOffset))
    self._units[unitIndex] = unit
end


function MultiBits.__tostring(bits)
    local ret = {}
    for idx, unit in ipairs(bits._units) do
        ret[idx] = string.reverse(string.format("%016X", unit))
    end
    return table.concat(ret)
end

return MultiBits
