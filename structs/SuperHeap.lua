local Heap = require("LuaLib.structs.Heap")

local SuperHeap = class("SuperHeap")

function SuperHeap:init()
    self.entire = Heap.new()
    self.remove = Heap.new()
end

function SuperHeap:Push(element)
    self.entire:Push(element)
end

function SuperHeap:Pop()
    while self.remove:Length() > 0 and self.remove:Top() == self.entire:Top() do
        self.remove:Pop()
        self.entire:Pop()
    end
    self.entire:Pop()
end

function SuperHeap:Remove(element)
    self.remove:Push(element)
end

function SuperHeap:Length()
    return self.entire:Length() - self.remove:Length()
end

function SuperHeap:Top()
    while self.remove:Length() > 0 and self.remove:Top() == self.entire:Top() do
        self.remove:Pop()
        self.entire:Pop()
    end
    self.entire:Top()
end

return SuperHeap
