local class = require("types.class")

local TestClass = class("TestClass")

function TestClass:init(testField)
    self.testField = testField
end

local testInstance = TestClass.new("This is testInstance's field")
print("the field: " .. tostring(testInstance.testField))
print("check isinstance: " .. tostring(testInstance:isinstance(TestClass)))

function TestClass:value()
    return "TestClass Value"
end

function TestClass:commonValue()
    return "TestClass Common Value"
end

local TestSonClass = class("TestSonClass", TestClass)
function TestSonClass:value()
    return "TestSonClass Value"
end

local sonInstance = TestSonClass.new("This is sonInstance's field")
print("sonInstance field: " .. tostring(sonInstance.testField))

print("testInstance value: " .. tostring(testInstance:value()))
print("sonInstance value: " .. tostring(sonInstance:value()))
print("sonInstance common value: " .. tostring(sonInstance:commonValue()))

print("check son isinstance of TestSonClass: " .. tostring(sonInstance:isinstance(TestSonClass))) 
print("check son isinstance of TestClass: " .. tostring(sonInstance:isinstance(TestClass)))

local TestOtherClass = class("TestOtherClass")
print("check son isinstance of TestOtherClass: " .. tostring(sonInstance:isinstance(TestOtherClass)))