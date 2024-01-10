local Heap = class("Heap")

function Heap:init()
    self.length = 0
    self.elements = {}
end

local function GetParentIndex(index)
    local parent = index // 2
    if parent > 0 then
        return parent
    end
end

local function Swim(elements, index)
    if index <= 0 or index > #elements then
        return
    end
    local parent = GetParentIndex(index)
    while parent and elements[index] < elements[parent] do
        elements[index], elements[parent] = elements[parent], elements[index]
        index = parent
        parent = GetParentIndex(index)
    end
end


local function GetSmallerSonIndex(elements, index, length)
    local fst = index * 2
    if fst <= length then
        local snd = index * 2 + 1
        if snd <= length then
            return elements[fst] < elements[snd] and fst or snd
        else
            return fst
        end
    end
end

local function Sink(elements, index)
    local length = #elements
    if index <= 0 or index > length then
        return
    end
    local son = GetSmallerSonIndex(elements, index, length)
    while son do
        if elements[son] >= elements[index] then
            break
        end
        elements[son], elements[index] = elements[index], elements[son]
        index = son
        son = GetSmallerSonIndex(elements, index, length)
    end
end

function Heap:Push(element)
    local length = self.length + 1
    self.length = length
    self.elements[length] = element
    if length > 1 then
        Swim(self.elements, length)
    end
end

function Heap:Pop()
    local length = self.length
    self.elements[1] = self.elements[length]
    self.elements[length] = nil
    self.length = length - 1
    if self.length > 1 then
        Sink(self.elements, 1)
    end
end

function Heap:Length()
    return self.length
end

function Heap:Top()
    return self.elements[1]
end

return Heap
