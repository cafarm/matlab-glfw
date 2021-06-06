classdef tglfw < matlab.unittest.TestCase
    methods (TestClassSetup)
        function init(testCase)
            testCase.applyFixture(PathFixture(["/usr/lib/x86_64-linux-gnu","/usr/include/GLFW"]));
            if ~libisloaded("libglfw")
                loadlibrary("libglfw", "glfw3");
            end
            r = calllib("libglfw", "glfwInit");
            testCase.fatalAssertTrue(logical(r));
        end
    end
    
    methods (TestClassTeardown)
        function terminate(~)
            calllib("libglfw", "glfwTerminate");
            unloadlibrary("libglfw");
        end
    end
    
    methods (Test)
        function getVersion(testCase)
            [major,minor,rev] = calllib("libglfw", "glfwGetVersion", 0, 0, 0);
            testCase.log(1,sprintf("Running against GLFW %i.%i.%i", major, minor, rev));
            testCase.verifyNotEmpty(major);
            testCase.verifyNotEmpty(minor);
            testCase.verifyNotEmpty(rev);
        end
    end
end

function f = PathFixture(varargin)
f = matlab.unittest.fixtures.PathFixture(varargin{:});
end