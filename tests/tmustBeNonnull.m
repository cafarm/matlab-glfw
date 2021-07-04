classdef tmustBeNonnull < matlab.unittest.TestCase
    methods (Test)
        function pass(~)
            mustBeNonnull(libpointer("int32Ptr",0));
        end
        
        function fail(testCase)
            testCase.verifyError(@()mustBeNonnull(libpointer), "GLFW:validators:mustBeNonnull");
            testCase.verifyError(@()mustBeNonnull(libpointer("int32Ptr")), "GLFW:validators:mustBeNonnull");
        end
    end
end

