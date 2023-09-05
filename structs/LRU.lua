local DoubleLinkedList = require("structs.DoubleLinkedList")

---@class LRU
---@field cache table @<key, node>
---@field order table @<key, value>
local LRU = class("LRU")

---@param capacity number
function LRU:init(capacity)
    self.capacity = capacity
    self.cache = {}
    self.order = DoubleLinkedList.new()
end

function LRU:Put(key, value)
    if self.capacity == 0 then
        local removeNode = self.order:RemoveTail().value
        self.cache[removeNode.key] = nil
        self.capacity = self.capacity + 1
    end
    self.capacity = self.capacity - 1
    local addedNode = DoubleLinkedList.NewNode({ key = key, value = value })
    self.order:InsertHead(addedNode)
    self.cache[key] = addedNode
end

function LRU:Get(key)
    local node = self.cache[key]
    if node then
        self.order:Remove(node)
        self.order:InsertHead(node)
        return node.value.value
    end
end

return LRU
