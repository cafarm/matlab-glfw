classdef tGLFWConstants < matlab.unittest.TestCase
    properties (TestParameter)
        Constant = allConstants();
    end

    methods (Test)
        function constantProperties(testCase, Constant)
            testCase.verifyMatches(Constant.Name, "^(?!GLFW_).+");
            testCase.verifyEqual(Constant.Constant, true, Constant.Name);
            testCase.verifyEqual(Constant.HasDefault, true, Constant.Name);
            testCase.verifyClass(Constant.DefaultValue, ?double, Constant.Name);
        end
    end
end

function c = allConstants()
mc = meta.class.fromName("GLFW");
c = num2cell(mc.PropertyList);
end