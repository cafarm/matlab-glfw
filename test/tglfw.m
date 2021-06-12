classdef tglfw < matlab.unittest.TestCase
    properties
        Window
    end
    
    methods (TestClassSetup)
        function init(testCase)
            success = glfwInit();
            if ~success
                [code,desc] = glfwGetError();
                testCase.fatalAssertFail(sprintf("%i:%s",code,desc));
            end
        end
    end
    
    methods (TestClassTeardown)
        function terminate(~)
            glfwTerminate();
        end
    end
    
    methods (TestMethodSetup)
        function createWindow(testCase)
            testCase.Window = glfwCreateWindow(640, 480, "Hello World");
            if isNull(testCase.Window)
                [code,desc] = glfwGetError();
                testCase.fatalAssertFail(sprintf("%i:%s",code,desc));
            end
        end
    end
    
    methods (TestMethodTeardown)
        function destroyWindow(testCase)
            glfwDestroyWindow(testCase.Window);
        end
    end
    
    methods (Test)
        function getVersion(testCase)
            [major,minor,rev] = glfwGetVersion();
            testCase.log(1, sprintf("Running against GLFW %i.%i.%i", major, minor, rev));
            testCase.verifyNotEmpty(major);
            testCase.verifyNotEmpty(minor);
            testCase.verifyNotEmpty(rev);
        end
        
        function makeContextCurrent(testCase)
            glfwMakeContextCurrent(testCase.Window);
        end
        
        function pollEvents(~)
            glfwPollEvents();
        end
        
        function swapBuffers(testCase)
            glfwSwapBuffers(testCase.Window);
        end
        
        function windowShouldClose(testCase)
            flag = glfwWindowShouldClose(testCase.Window);
            testCase.verifyEqual(flag, 0);
        end
    end
end

function f = PathFixture(varargin)
f = matlab.unittest.fixtures.PathFixture(varargin{:});
end

function p = thisFolder()
p = fileparts(mfilename("fullpath"));
end