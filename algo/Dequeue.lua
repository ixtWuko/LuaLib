---@class Dequeue
local Dequeue = class('Dequeue')

function Dequeue:init(initial_elements)
    self._data = initial_elements or {}
    self._head = 1
    self._tail = #self._data + 1
end

function Dequeue:isEmpty()
    return self._tail == self._head
end

function Dequeue:length()
    return self._tail - self._head
end

function Dequeue:putLeft(element)
    self._head = self._head - 1
    self._data[self._head] = element
end

function Dequeue:putRight(element)
    self._data[self._tail] = element
    self._tail = self._tail + 1
end

function Dequeue:getLeft()
    if self._tail == self._head then
        return nil
    end
    local ret = self._data[self._head]
    self._data[self._head] = nil
    self._head = self._head + 1
    return ret
end

function Dequeue:getRight()
    if self._tail == self._head then
        return nil
    end
    self._tail = self._tail - 1
    local ret = self._data[self._tail]
    self._data[self._tail] = nil
    return ret
end

function Dequeue:clear()
    self:init()
end

return Dequeue
