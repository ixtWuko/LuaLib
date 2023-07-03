local MaxInteger = math.maxinteger

---@class Counter
local Counter = class("Counter")

function Counter:init(startNumber, stopNumber)
    self._startNumber = startNumber or 0
    self._stopNumber = stopNumber or MaxInteger
    self.count = self._startNumber
end

function Counter:Get()
    return self.count
end

function Counter:Set(count)
    if count < self._startNumber or count > self._stopNumber then
        return false
    end
    self.count = count
    return true
end

function Counter:Reset()
    self.count = self._startNumber
end

function Counter:Increase()
    if self.count == self._stopNumber then
        return false
    end
    self.count = self.count + 1
    return true
end

function Counter:Decrease()
    if self.count == self._startNumber then
        return false
    end
    self.count = self.count - 1
    return true
end

function Counter:MultipleIncrease(times)
    if times - 1 + self.count >= self._stopNumber then
        return false
    end
    self.count = self.count + times
    return true
end

function Counter:MultipleDecrease(times)
    if self.count - (times - 1) <= self._startNumber then
        return false
    end
    self.count = self.count - times
    return true
end

return Counter
