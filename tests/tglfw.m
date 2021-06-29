classdef tglfw < matlab.unittest.TestCase
    properties
        Window
    end
    
    methods (TestClassSetup)
        function init(testCase)
            glfwInitHint(GLFW.JOYSTICK_HAT_BUTTONS, GLFW.TRUE);
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
            glfwWindowHint(GLFW.VISIBLE, GLFW.TRUE);
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
        function getError(testCase)
            [code,desc] = glfwGetError();
            testCase.verifyTrue(isnumeric(code));
            testCase.verifyClass(desc, ?string);
        end

        function getFramebufferSize(testCase)
            [width,height] = glfwGetFramebufferSize(testCase.Window);
            testCase.verifyTrue(isnumeric(width));
            testCase.verifyTrue(isnumeric(height));
        end

        function getMonitors(testCase)
            [monitors,count] = glfwGetMonitors();
            testCase.verifyClass(monitors, "lib.pointer");
            testCase.verifyTrue(isnumeric(count));
        end

        function getPrimaryMonitor(testCase)
            monitor = glfwGetPrimaryMonitor();
            testCase.verifyClass(monitor, "lib.pointer");
        end

        function getTime(testCase)
            time = glfwGetTime();
            testCase.verifyTrue(isnumeric(time));
        end
        
        function getVersion(testCase)
            [major,minor,rev] = glfwGetVersion();
            testCase.log(1, sprintf("Running against GLFW %i.%i.%i", major, minor, rev));
            testCase.verifyTrue(isnumeric(major));
            testCase.verifyTrue(isnumeric(minor));
            testCase.verifyTrue(isnumeric(rev));
        end

        function glfwGetWindowSize(testCase)
            [width,height] = glfwGetWindowSize(testCase.Window);
            testCase.verifyEqual(double(width), 640);
            testCase.verifyEqual(double(height), 480);
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

        function swapInterval(~)
            glfwSwapInterval(1);
        end
        
        function windowShouldClose(testCase)
            flag = glfwWindowShouldClose(testCase.Window);
            testCase.verifyEqual(flag, 0);
        end
    end
end