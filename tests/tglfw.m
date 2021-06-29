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
                testCase.fatalAssertFail(sprintf("%d:%s",code,desc));
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
                testCase.fatalAssertFail(sprintf("%d:%s",code,desc));
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
            testCase.verifyClass(code, ?double);
            testCase.verifyClass(desc, ?string);
        end

        function getFramebufferSize(testCase)
            [width,height] = glfwGetFramebufferSize(testCase.Window);
            testCase.verifyClass(width, ?double);
            testCase.verifyClass(height, ?double);
        end

        function getMonitors(testCase)
            [monitors,count] = glfwGetMonitors();
            testCase.verifyClass(monitors, "lib.pointer");
            testCase.verifyClass(count, ?double);
        end

        function getPrimaryMonitor(testCase)
            monitor = glfwGetPrimaryMonitor();
            testCase.verifyClass(monitor, "lib.pointer");
        end

        function getTime(testCase)
            time = glfwGetTime();
            testCase.verifyClass(time, ?double);
        end
        
        function getVersion(testCase)
            [major,minor,rev] = glfwGetVersion();
            testCase.log(1, sprintf("Running against GLFW %d.%d.%d", major, minor, rev));
            testCase.verifyClass(major, ?double);
            testCase.verifyClass(minor, ?double);
            testCase.verifyClass(rev, ?double);
        end

        function glfwGetWindowSize(testCase)
            [width,height] = glfwGetWindowSize(testCase.Window);
            testCase.verifyEqual(width, 640);
            testCase.verifyEqual(height, 480);
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