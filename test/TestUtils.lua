local TestUtils = {}

function TestUtils.PrintPcall(...)
    local success, error = pcall(...)
    if not success then
        print(error)
    end
end

return TestUtils