local TestUtils = require("test.TestUtils")
local enum = require("types.enum")

local Color = enum {
    Red = 1,
    Green = 2,
    Blue = 3,
}
print("Color.Red = " .. tostring(Color.Red))
print("Color.Green = " .. tostring(Color.Green))
print("Color.Blue = " .. tostring(Color.Blue))
print("Color.Yellow = " .. tostring(Color.Yellow))

TestUtils.PrintPcall(function()
    print("Try to modify Color.Red")
    Color.Red = 4
end)
TestUtils.PrintPcall(function()
    print("Try to modify Color.Yellow")
    Color.Yellow = 4
end)

local parent = {}
parent.Color = enum {
    Red = 1,
    Green = 2,
    Blue = 3,
}
parent.Compare = {
    value = 0
}
collectgarbage()
print("After first gc:")
print("The field Color is still exist: " .. tostring(parent.Color ~= nil))
print("parent.Color is " .. tostring(parent.Color))
print("The field Compare is still exist: " .. tostring(parent.Compare ~= nil))
print("parent.Compare is " .. tostring(parent.Compare))