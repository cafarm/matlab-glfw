classdef tglfw < matlab.unittest.TestCase
    properties
        Window
        Monitor
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

        function getPrimaryMonitor(testCase)
            testCase.Monitor = glfwGetPrimaryMonitor();
            if isNull(testCase.Monitor)
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
        %% Context
        function makeContextCurrent(testCase)
            glfwMakeContextCurrent(testCase.Window);
        end

        function getCurrentContext(testCase)
            window = glfwGetCurrentContext();
            testCase.verifyClass(window, "lib.pointer");
        end

        function swapInterval(~)
            glfwSwapInterval(1);
        end

        function extensionSupported(testCase)
            avail = glfwExtensionSupported("GL_ARB_debug_output");
            testCase.verifyClass(avail, ?double);
        end

        function getProcAddress(testCase)
            addr = glfwGetProcAddress("glGetDebugMessageLogARB");
            testCase.verifyClass(addr, "lib.pointer");
        end

        %% Initialization, version and error
        function getVersion(testCase)
            [major,minor,rev] = glfwGetVersion();
            testCase.log(1, sprintf("Running against GLFW %d.%d.%d", major, minor, rev));
            testCase.verifyClass(major, ?double);
            testCase.verifyClass(minor, ?double);
            testCase.verifyClass(rev, ?double);
        end

        function getVersionString(testCase)
            version = glfwGetVersionString();
            testCase.log(1, sprintf("Running against GLFW %s", version));
            testCase.verifyClass(version, ?string);
        end

        function getError(testCase)
            [code,desc] = glfwGetError();
            testCase.verifyClass(code, ?double);
            testCase.verifyClass(desc, ?string);
        end

        %% Input
        function getInputMode(testCase)
            value = glfwGetInputMode(testCase.Window, GLFW.CURSOR);
            testCase.verifyClass(value, ?double)
        end

        function getKeyName(testCase)
            name = glfwGetKeyName(GLFW.KEY_W, 0);
            testCase.verifyClass(name, ?string)
        end

        function getKeyScancode(testCase)
            code = glfwGetKeyScancode(GLFW.KEY_X);
            testCase.verifyClass(code, ?double)
        end

        function getKey(testCase)
            state = glfwGetKey(testCase.Window, GLFW.KEY_X);
            testCase.verifyClass(state, ?double)
        end

        function getCursorPos(testCase)
            [x,y] = glfwGetCursorPos(testCase.Window);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
        end

        function createCursor(testCase)
            cursor = glfwCreateCursor(0xff*ones(16,16,4,"uint8"), 0, 0);
            testCase.verifyClass(cursor, "lib.pointer");
            testCase.verifyFalse(isNull(cursor));
            glfwDestroyCursor(cursor);
        end

        function createStandardCursor(testCase)
            cursor = glfwCreateStandardCursor(GLFW.ARROW_CURSOR);
            testCase.verifyClass(cursor, "lib.pointer");
            testCase.verifyFalse(isNull(cursor));
            glfwDestroyCursor(cursor);
        end

        function getJoystickAxes(testCase)
            [axes,count] = glfwGetJoystickAxes(GLFW.JOYSTICK_1);
            testCase.verifyClass(axes, "lib.pointer");
            testCase.verifyClass(count, ?double);
        end

        function getJoystickButtons(testCase)
            [buttons,count] = glfwGetJoystickButtons(GLFW.JOYSTICK_1);
            testCase.verifyClass(buttons, "lib.pointer");
            testCase.verifyClass(count, ?double);
        end

        function getJoystickHats(testCase)
            [hats,count] = glfwGetJoystickHats(GLFW.JOYSTICK_1);
            testCase.verifyClass(hats, "lib.pointer");
            testCase.verifyClass(count, ?double);
        end

        function getJoystickName(testCase)
            name = glfwGetJoystickName(GLFW.JOYSTICK_1);
            testCase.verifyClass(name, ?string);
        end

        function getJoystickGUID(testCase)
            guid = glfwGetJoystickGUID(GLFW.JOYSTICK_1);
            testCase.verifyClass(guid, ?string);
        end

        function getJoystickUserPointer(testCase)
            pointer = glfwGetJoystickUserPointer(GLFW.JOYSTICK_1);
            testCase.verifyClass(pointer, "lib.pointer");
        end

        function getGamepadName(testCase)
            name = glfwGetGamepadName(GLFW.JOYSTICK_1);
            testCase.verifyClass(name, ?string);
        end

        function getGamepadState(testCase)
            [conn, state] = glfwGetGamepadState(GLFW.JOYSTICK_1);
            testCase.verifyClass(conn, ?double);
            testCase.verifyClass(state, ?struct);
        end

        function getClipboardString(testCase)
            contents = glfwGetClipboardString(testCase.Window);
            testCase.verifyClass(contents, ?string);
        end

        function getTime(testCase)
            time = glfwGetTime();
            testCase.verifyClass(time, ?double);
        end

        %% Monitor
        function getMonitors(testCase)
            [monitors,count] = glfwGetMonitors();
            testCase.verifyClass(monitors, "lib.pointer");
            testCase.verifyClass(count, ?double);
        end

        function getMonitorPos(testCase)
            [x,y] = glfwGetMonitorPos(testCase.Monitor);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
        end

        function getMonitorPhysicalSize(testCase)
            [w,h] = glfwGetMonitorPhysicalSize(testCase.Monitor);
            testCase.verifyClass(w, ?double);
            testCase.verifyClass(h, ?double);
        end

        function getMonitorContentScale(testCase)
            [x,y] = glfwGetMonitorContentScale(testCase.Monitor);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
        end

        function getMonitorName(testCase)
            name = glfwGetMonitorName(testCase.Monitor);
            testCase.verifyClass(name, ?string);
        end

        function getGammaRamp(testCase)
            ramp = glfwGetGammaRamp(testCase.Monitor);
            testCase.verifyClass(ramp, "lib.pointer");
        end

        %% Native

        %% Vulkan support

        %% Window
        function defaultWindowHints(~)
            glfwDefaultWindowHints();
        end

        function windowShouldClose(testCase)
            flag = glfwWindowShouldClose(testCase.Window);
            testCase.verifyEqual(flag, 0);
        end

        function glfwGetWindowSize(testCase)
            [width,height] = glfwGetWindowSize(testCase.Window);
            testCase.verifyEqual(width, 640);
            testCase.verifyEqual(height, 480);
        end

        function getFramebufferSize(testCase)
            [width,height] = glfwGetFramebufferSize(testCase.Window);
            testCase.verifyClass(width, ?double);
            testCase.verifyClass(height, ?double);
        end

        function focusWindow(testCase)
            glfwFocusWindow(testCase.Window);
        end
        
        function pollEvents(~)
            glfwPollEvents();
        end
        
        function swapBuffers(testCase)
            glfwSwapBuffers(testCase.Window);
        end
    end
end