classdef tglfw < matlab.unittest.TestCase
    properties
        Window
        Monitor
    end
    
    methods (TestClassSetup)
        function init(testCase)
            glfwInit();
            previousCallback = glfwSetErrorCallback(@(c,d)fprintf("%d:%s\n",c,d));
            testCase.addTeardown(@()glfwSetErrorCallback(previousCallback));
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
        end

        function getPrimaryMonitor(testCase)
            testCase.Monitor = glfwGetPrimaryMonitor();
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

        function makeContextCurrentValidates(testCase)
            testCase.verifyError(@()glfwMakeContextCurrent(1), "GLFW:validators:mustBeLibPointer");
            testCase.verifyError(@()glfwMakeContextCurrent(libpointer("int32Ptr",0)), "GLFW:validators:mustBeLibPointer");
            testCase.verifyError(@()glfwMakeContextCurrent(libpointer("GLFWwindowPtr")), "GLFW:validators:mustBeNonnull");
        end

        function getCurrentContext(testCase)
            window = glfwGetCurrentContext();
            testCase.verifyLibPointer(window, "GLFWwindowPtr");
        end

        function swapInterval(~)
            glfwSwapInterval(1);
        end

        function extensionSupported(testCase)
            supported = glfwExtensionSupported("GL_ARB_debug_output");
            testCase.verifyClass(supported, ?double);
        end

        function getProcAddressThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwGetProcAddress("glGetDebugMessageLogARB"), "GLFW:getProcAddress:GLFW_NOT_INITIALIZED");
        end

        %% Initialization, version and error
        function initHint(~)
            glfwInitHint(GLFW.JOYSTICK_HAT_BUTTONS, GLFW.TRUE);
        end

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

        function setErrorCallback(testCase)
            clear glfwSetErrorCallback;
            testCase.verifyError(@()glfwSetErrorCallback(@()[]), "GLFW:validators:mustBeCallback");
            callback = @(c,d)disp("called");
            testCase.verifyEmpty(glfwSetErrorCallback(callback));
            previousCallback = glfwSetErrorCallback();
            testCase.verifyEqual(previousCallback, callback);
        end

        %% Input
        function inputMode(testCase)
            glfwSetInputMode(testCase.Window, GLFW.CURSOR, GLFW.CURSOR_HIDDEN);
            value = glfwGetInputMode(testCase.Window, GLFW.CURSOR);
            testCase.verifyEqual(value, GLFW.CURSOR_HIDDEN);
        end

        function rawMouseMotionSupported(testCase)
            supported = glfwRawMouseMotionSupported();
            testCase.verifyClass(supported, ?double);
        end

        function getKeyName(testCase)
            name = glfwGetKeyName(GLFW.KEY_W, 0);
            testCase.verifyClass(name, ?string);
        end

        function getKeyScancode(testCase)
            code = glfwGetKeyScancode(GLFW.KEY_X);
            testCase.verifyClass(code, ?double);
        end

        function getKey(testCase)
            state = glfwGetKey(testCase.Window, GLFW.KEY_X);
            testCase.verifyClass(state, ?double);
        end

        function getMouseButton(testCase)
            state = glfwGetMouseButton(testCase.Window, GLFW.MOUSE_BUTTON_LEFT);
            testCase.verifyClass(state, ?double);
        end

        function cursorPos(testCase)
            glfwSetCursorPos(testCase.Window, 5, 10);
            [x,y] = glfwGetCursorPos(testCase.Window);
            testCase.verifyEqual(x, 5);
            testCase.verifyEqual(y, 10);
        end

        function createCursor(testCase)
            cursor = glfwCreateCursor(0xff*ones(16,16,4,"uint8"), 0, 0);
            testCase.verifyLibPointer(cursor, "GLFWcursorPtr");
            testCase.verifyFalse(isNull(cursor));
            glfwDestroyCursor(cursor);
        end

        function createCursorThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwCreateCursor(0xff*ones(16,16,4,"uint8"), 0, 0), "GLFW:createCursor:GLFW_NOT_INITIALIZED");
        end

        function createStandardCursor(testCase)
            cursor = glfwCreateStandardCursor(GLFW.ARROW_CURSOR);
            testCase.verifyLibPointer(cursor, "GLFWcursorPtr");
            testCase.verifyFalse(isNull(cursor));
            glfwDestroyCursor(cursor);
        end

        function createStandardCursorThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwCreateStandardCursor(GLFW.ARROW_CURSOR), "GLFW:createStandardCursor:GLFW_NOT_INITIALIZED");
        end

        function setCursor(testCase)
            cursor = glfwCreateStandardCursor(GLFW.ARROW_CURSOR);
            glfwSetCursor(testCase.Window, cursor);
        end

        function setKeyCallback(testCase)
            testCase.verifyError(@()glfwSetKeyCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,k,c,a,m)disp("called");
            testCase.verifyEmpty(glfwSetKeyCallback(testCase.Window, callback));
            previousCallback = glfwSetKeyCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setCharCallback(testCase)
            testCase.verifyError(@()glfwSetCharCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,p)disp("called");
            testCase.verifyEmpty(glfwSetCharCallback(testCase.Window, callback));
            previousCallback = glfwSetCharCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setCharModsCallback(testCase)
            testCase.verifyError(@()glfwSetCharModsCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,p,m)disp("called");
            testCase.verifyEmpty(glfwSetCharModsCallback(testCase.Window, callback));
            previousCallback = glfwSetCharModsCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setMouseButtonCallback(testCase)
            testCase.verifyError(@()glfwSetMouseButtonCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,b,a,m)disp("called");
            testCase.verifyEmpty(glfwSetMouseButtonCallback(testCase.Window, callback));
            previousCallback = glfwSetMouseButtonCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setCursorPosCallback(testCase)
            testCase.verifyError(@()glfwSetCursorPosCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,x,y)disp("called");
            testCase.verifyEmpty(glfwSetCursorPosCallback(testCase.Window, callback));
            previousCallback = glfwSetCursorPosCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setCursorEnterCallback(testCase)
            testCase.verifyError(@()glfwSetCursorEnterCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,e)disp("called");
            testCase.verifyEmpty(glfwSetCursorEnterCallback(testCase.Window, callback));
            previousCallback = glfwSetCursorEnterCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setScrollCallback(testCase)
            testCase.verifyError(@()glfwSetScrollCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,x,y)disp("called");
            testCase.verifyEmpty(glfwSetScrollCallback(testCase.Window, callback));
            previousCallback = glfwSetScrollCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setDropCallback(testCase)
            testCase.verifyError(@()glfwSetDropCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,c,p)disp("called");
            testCase.verifyEmpty(glfwSetDropCallback(testCase.Window, callback));
            previousCallback = glfwSetDropCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function joystickPresent(testCase)
            present = glfwJoystickPresent(GLFW.JOYSTICK_1);
            testCase.verifyClass(present, ?double);
        end

        function getJoystickAxes(testCase)
            [axes,count] = glfwGetJoystickAxes(GLFW.JOYSTICK_1);
            testCase.verifyClass(axes, ?double);
            testCase.verifyClass(count, ?double);
        end

        function getJoystickButtons(testCase)
            [buttons,count] = glfwGetJoystickButtons(GLFW.JOYSTICK_1);
            testCase.verifyClass(buttons, ?double);
            testCase.verifyClass(count, ?double);
        end

        function getJoystickHats(testCase)
            [hats,count] = glfwGetJoystickHats(GLFW.JOYSTICK_1);
            testCase.verifyClass(hats, ?double);
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

        function setJoystickUserPointer(~)
            glfwSetJoystickUserPointer(GLFW.JOYSTICK_1, libpointer("doublePtr",0));
        end

        function getJoystickUserPointer(testCase)
            pointer = glfwGetJoystickUserPointer(GLFW.JOYSTICK_1);
            testCase.verifyLibPointer(pointer, "voidPtr");
        end

        function joystickIsGamepad(testCase)
            isGamepad = glfwJoystickIsGamepad(GLFW.JOYSTICK_1);
            testCase.verifyClass(isGamepad, ?double);
        end

        function setJoystickCallback(testCase)
            testCase.verifyError(@()glfwSetJoystickCallback(@()[]), "GLFW:validators:mustBeCallback");
            callback = @(j,e)disp("called");
            testCase.verifyEmpty(glfwSetJoystickCallback(callback));
            previousCallback = glfwSetJoystickCallback();
            testCase.verifyEqual(previousCallback, callback);
        end

        function updateGamepadMappings(~)
            glfwUpdateGamepadMappings("");
        end

        function updateGamepadMappingsThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwUpdateGamepadMappings(""), "GLFW:updateGamepadMappings:GLFW_NOT_INITIALIZED");
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

        function clipboardString(testCase)
            glfwSetClipboardString("clip");
            contents = glfwGetClipboardString();
            testCase.verifyEqual(contents, "clip");
        end

        function time(testCase)
            glfwSetTime(100);
            time = glfwGetTime();
            testCase.verifyGreaterThanOrEqual(time, 100);
        end

        function getTimerValue(testCase)
            value = glfwGetTimerValue();
            testCase.verifyClass(value, ?double);
        end

        function getTimerFrequency(testCase)
            freq = glfwGetTimerFrequency();
            testCase.verifyClass(freq, ?double);
        end

        %% Monitor
        function getMonitors(testCase)
            [monitors,count] = glfwGetMonitors();
            testCase.verifyLibPointer(monitors, "GLFWmonitorPtr");
            testCase.verifyClass(count, ?double);
        end

        function getMonitorPos(testCase)
            [x,y] = glfwGetMonitorPos(testCase.Monitor);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
        end

        function getMonitorWorkarea(testCase)
            [x,y,w,h] = glfwGetMonitorWorkarea(testCase.Monitor);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
            testCase.verifyClass(w, ?double);
            testCase.verifyClass(h, ?double);
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

        function monitorUserPointer(testCase)
            in = libpointer("doublePtr", [5 10]);
            glfwSetMonitorUserPointer(testCase.Monitor, in);
            out = glfwGetMonitorUserPointer(testCase.Monitor);
            setdatatype(out, "doublePtr", 2);
            testCase.verifyEqual(out.Value', [5 10]);
        end

        function setMonitorCallback(testCase)
            testCase.verifyError(@()glfwSetMonitorCallback(@()[]), "GLFW:validators:mustBeCallback");
            callback = @(m,e)disp("called");
            testCase.verifyEmpty(glfwSetMonitorCallback(callback));
            previousCallback = glfwSetMonitorCallback();
            testCase.verifyEqual(previousCallback, callback);
        end

        function getVideoModes(testCase)
            [modes,count] = glfwGetVideoModes(testCase.Monitor);
            testCase.verifyClass(modes, ?struct);
            testCase.verifyClass(count, ?double);
        end

        function getVideoModesThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwGetVideoModes(testCase.Monitor), "GLFW:getVideoModes:GLFW_NOT_INITIALIZED");
        end

        function getVideoMode(testCase)
            mode = glfwGetVideoMode(testCase.Monitor);
            testCase.verifyClass(mode, ?struct);
        end

        function getVideoModeThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwGetVideoMode(testCase.Monitor), "GLFW:getVideoMode:GLFW_NOT_INITIALIZED");
        end

        function setGamma(testCase)
            glfwSetGamma(testCase.Monitor, 1);
        end

        function gammaRamp(testCase)
            try
                orig = glfwGetGammaRamp(testCase.Monitor);
            catch e
                if strcmp(e.identifier, "GLFW:getGammaRamp:GLFW_PLATFORM_ERROR")
                    testCase.assumeFail(e.message);
                end
            end
            new = orig;
            new.red = flip(new.red);
            new.green = flip(new.green);
            new.blue = flip(new.blue);
            glfwSetGammaRamp(testCase.Monitor, new);
            act = glfwGetGammaRamp(testCase.Monitor);
            testCase.verifyEqual(act, new);
            glfwSetGammaRamp(testCase.Monitor, orig);
        end

        function getGammaRampThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwGetGammaRamp(testCase.Monitor), "GLFW:getGammaRamp:GLFW_NOT_INITIALIZED");
        end

        function setGammaRampInvalid(testCase)
            m = testCase.Monitor;
            testCase.verifyError(@()glfwSetGammaRamp(m,1), "GLFW:validators:mustBeValidRamp");
            testCase.verifyError(@()glfwSetGammaRamp(m,struct), "GLFW:validators:mustBeValidRamp");
            testCase.verifyError(@()glfwSetGammaRamp(m,struct("red",[],"green",[],"blue",[])), "GLFW:validators:mustBeValidRamp");
            testCase.verifyError(@()glfwSetGammaRamp(m,struct("red",1,"green",1,"blue",1,"size",3)), "GLFW:validators:mustBeValidRamp");
        end

        %% Vulkan support
        function vulkanSupported(testCase)
            supported = glfwVulkanSupported();
            testCase.verifyClass(supported, ?double);
        end

        function getRequiredInstanceExtensions(testCase)
            [names,count] = glfwGetRequiredInstanceExtensions();
            testCase.verifyLibPointer(names, "stringPtrPtr");
            testCase.verifyClass(count, ?double);
        end

        %% Window
        function defaultWindowHints(~)
            glfwDefaultWindowHints();
        end

        function windowHint(~)
            glfwWindowHint(GLFW.VISIBLE, GLFW.TRUE);
        end

        function windowHintString(~)
            glfwWindowHintString(GLFW.COCOA_FRAME_NAME, "");
        end

        function createWindowThrows(testCase)
            glfwTerminate();
            testCase.Window = libpointer("GLFWwindowPtr");
            init = onCleanup(@glfwInit);
            testCase.verifyError(@()glfwCreateWindow(640,480,"t"), "GLFW:createWindow:GLFW_NOT_INITIALIZED");
        end

        function windowShouldClose(testCase)
            glfwSetWindowShouldClose(testCase.Window, GLFW.TRUE);
            flag = glfwWindowShouldClose(testCase.Window);
            testCase.verifyEqual(flag, GLFW.TRUE);
        end

        function setWindowTitle(testCase)
            glfwSetWindowTitle(testCase.Window, "title");
        end

        function setWindowIcon(testCase)
            glfwSetWindowIcon(testCase.Window, 0xff*ones(16,16,4,"uint8"));
        end

        function getWindowPos(testCase)
            glfwSetWindowPos(testCase.Window, 100, 150);
            [x,y] = glfwGetWindowPos(testCase.Window);
            testCase.verifyEqual(x, 100);
            testCase.verifyEqual(y, 150);
        end

        function windowSize(testCase)
            glfwSetWindowSize(testCase.Window, 100, 150);
            [width,height] = glfwGetWindowSize(testCase.Window);
            testCase.verifyEqual(width, 100);
            testCase.verifyEqual(height, 150);
        end

        function setWindowSizeLimits(testCase)
            glfwSetWindowSizeLimits(testCase.Window, 200, 200, 400, 400);
        end

        function setWindowAspectRatio(testCase)
            glfwSetWindowAspectRatio(testCase.Window, 16, 9);
        end

        function getFramebufferSize(testCase)
            [width,height] = glfwGetFramebufferSize(testCase.Window);
            testCase.verifyClass(width, ?double);
            testCase.verifyClass(height, ?double);
        end

        function getWindowFrameSize(testCase)
            [l,t,r,b] = glfwGetWindowFrameSize(testCase.Window);
            testCase.verifyClass(l, ?double);
            testCase.verifyClass(t, ?double);
            testCase.verifyClass(r, ?double);
            testCase.verifyClass(b, ?double);
        end

        function getWindowContentScale(testCase)
            [x,y] = glfwGetWindowContentScale(testCase.Window);
            testCase.verifyClass(x, ?double);
            testCase.verifyClass(y, ?double);
        end

        function setWindowOpacity(testCase)
            glfwSetWindowOpacity(testCase.Window, 0.5);
        end

        function getWindowOpacity(testCase)
            opacity = glfwGetWindowOpacity(testCase.Window);
            testCase.verifyClass(opacity, ?double);
        end

        function iconifyWindow(testCase)
            glfwIconifyWindow(testCase.Window);
        end

        function restoreWindow(testCase)
            glfwRestoreWindow(testCase.Window);
        end

        function maximizeWindow(testCase)
            glfwMaximizeWindow(testCase.Window);
        end

        function showWindow(testCase)
            glfwHideWindow(testCase.Window);
            glfwShowWindow(testCase.Window);
            value = glfwGetWindowAttrib(testCase.Window, GLFW.VISIBLE);
            testCase.verifyEqual(value, GLFW.TRUE);
        end

        function hideWindow(testCase)
            glfwHideWindow(testCase.Window);
            value = glfwGetWindowAttrib(testCase.Window, GLFW.VISIBLE);
            testCase.verifyEqual(value, GLFW.FALSE);
        end

        function focusWindow(testCase)
            glfwFocusWindow(testCase.Window);
            value = glfwGetWindowAttrib(testCase.Window, GLFW.FOCUSED);
            testCase.verifyEqual(value, GLFW.TRUE);
        end

        function requestWindowAttention(testCase)
            glfwRequestWindowAttention(testCase.Window);
        end

        function getWindowMonitor(testCase)
            monitor = glfwGetWindowMonitor(testCase.Window);
            testCase.verifyLibPointer(monitor, "GLFWmonitorPtr");
        end

        function setWindowMonitor(testCase)
            glfwSetWindowMonitor(testCase.Window, 0, 0, 640, 480, 60);
        end

        function windowAttrib(testCase)
            glfwSetWindowAttrib(testCase.Window, GLFW.RESIZABLE, GLFW.FALSE);
            value = glfwGetWindowAttrib(testCase.Window, GLFW.RESIZABLE);
            testCase.verifyEqual(value, GLFW.FALSE);
        end

        function windowUserPointer(testCase)
            in = libpointer("doublePtr", [5 10]);
            glfwSetWindowUserPointer(testCase.Window, in);
            out = glfwGetWindowUserPointer(testCase.Window);
            setdatatype(out, "doublePtr", 2);
            testCase.verifyEqual(out.Value', [5 10]);
        end

        function setWindowPosCallback(testCase)
            testCase.verifyError(@()glfwSetWindowPosCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,x,y)disp("called");
            testCase.verifyEmpty(glfwSetWindowPosCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowPosCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowSizeCallback(testCase)
            testCase.verifyError(@()glfwSetWindowSizeCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,wt,h)disp("called");
            testCase.verifyEmpty(glfwSetWindowSizeCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowSizeCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowCloseCallback(testCase)
            testCase.verifyError(@()glfwSetWindowCloseCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w)disp("called");
            testCase.verifyEmpty(glfwSetWindowCloseCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowCloseCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowRefreshCallback(testCase)
            testCase.verifyError(@()glfwSetWindowRefreshCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w)disp("called");
            testCase.verifyEmpty(glfwSetWindowRefreshCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowRefreshCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowFocusCallback(testCase)
            testCase.verifyError(@()glfwSetWindowFocusCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,f)disp("called");
            testCase.verifyEmpty(glfwSetWindowFocusCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowFocusCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowIconifyCallback(testCase)
            testCase.verifyError(@()glfwSetWindowIconifyCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,i)disp("called");
            testCase.verifyEmpty(glfwSetWindowIconifyCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowIconifyCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowMaximizeCallback(testCase)
            testCase.verifyError(@()glfwSetWindowMaximizeCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,m)disp("called");
            testCase.verifyEmpty(glfwSetWindowMaximizeCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowMaximizeCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setFramebufferSizeCallback(testCase)
            testCase.verifyError(@()glfwSetFramebufferSizeCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,wt,h)disp("called");
            testCase.verifyEmpty(glfwSetFramebufferSizeCallback(testCase.Window, callback));
            previousCallback = glfwSetFramebufferSizeCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end

        function setWindowContentScaleCallback(testCase)
            testCase.verifyError(@()glfwSetWindowContentScaleCallback(testCase.Window, @()[]), "GLFW:validators:mustBeCallback");
            callback = @(w,x,y)disp("called");
            testCase.verifyEmpty(glfwSetWindowContentScaleCallback(testCase.Window, callback));
            previousCallback = glfwSetWindowContentScaleCallback(testCase.Window);
            testCase.verifyEqual(previousCallback, callback);
        end
        
        function pollEvents(~)
            glfwPollEvents();
        end

        function waitEvents(~)
            glfwWaitEvents();
        end

        function waitEventsTimeout(~)
            glfwWaitEventsTimeout(0.7);
        end

        function postEmptyEvent(~)
            glfwPostEmptyEvent();
        end
        
        function swapBuffers(testCase)
            glfwSwapBuffers(testCase.Window);
        end
    end

    methods
        function verifyLibPointer(testCase, actual, type)
            testCase.verifyClass(actual, "lib.pointer");
            testCase.verifyEqual(string(actual.DataType), string(type));
        end
    end
end