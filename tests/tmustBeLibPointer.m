classdef tmustBeLibPointer < matlab.unittest.TestCase
    methods (Test)
        function pass(~)
            mustBeLibPointer(libpointer);
        end
        
        function fail(testCase)
            testCase.verifyError(@()mustBeLibPointer([]), ?MException);
        end
    end
end

