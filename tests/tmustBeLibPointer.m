classdef tmustBeLibPointer < matlab.unittest.TestCase
    methods (Test)
        function pass(~)
            mustBeLibPointer(libpointer("int32Ptr"), "int32Ptr");
        end
        
        function fail(testCase)
            testCase.verifyError(@()mustBeLibPointer(libpointer, "int32Ptr"), "GLFW:validators:mustBeLibPointer");
            testCase.verifyError(@()mustBeLibPointer(libpointer("int32Ptr"), "doublePtr"), "GLFW:validators:mustBeLibPointer");
        end
    end
end

