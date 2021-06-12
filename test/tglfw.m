classdef tglfw < matlab.unittest.TestCase
    methods (TestClassSetup)
        function init(testCase)
            testCase.applyFixture(PathFixture(fullfile(thisFolder(), "..", "src")));
            testCase.applyFixture(PathFixture(["/usr/local/lib","/usr/local/include/GLFW"]));
            success = glfwInit();
            if ~success
                [code,desc] = glfwGetError();
                testCase.fatalAssertFail(sprintf("%i:%s",code,strjoin(desc)));
            end
        end
    end
    
    methods (TestClassTeardown)
        function terminate(~)
            glfwTerminate();
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
    end
end

function f = PathFixture(varargin)
f = matlab.unittest.fixtures.PathFixture(varargin{:});
end

function p = thisFolder()
p = fileparts(mfilename("fullpath"));
end