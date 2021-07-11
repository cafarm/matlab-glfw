#include <map>
#include "mex.hpp"
#include "mexAdapter.hpp"
#include "GLFW/glfw3.h"

using namespace std;
using namespace matlab::mex;
using namespace matlab::data;

static function<void(int code, const char* description)> errorCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int key, int scancode, int action, int mods)>> keyCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, unsigned int codepoint)>> charCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, unsigned int codepoint, int mods)>> charModsCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int button, int action, int mods)>> mouseButtonCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, double xpos, double ypos)>> cursorPosCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int entered)>> cursorEnterCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, double xoffset, double yoffset)>> scrollCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int pathCount, const char* paths[])>> dropCallbackFunction;
static function<void(int jid, int event)> joystickCallbackFunction;
static function<void(GLFWmonitor* monitor, int event)> monitorCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int xpos, int ypos)>> windowPosCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int width, int height)>> windowSizeCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window)>> windowCloseCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window)>> windowRefreshCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int focused)>> windowFocusCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int iconified)>> windowIconifyCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int maximized)>> windowMaximizeCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, int width, int height)>> framebufferSizeCallbackFunction;
static map<GLFWwindow*,function<void(GLFWwindow* window, float xscale, float yscale)>> windowContentScaleCallbackFunction;

static void errorCallbackFunctionHelper(int code, const char* description) {
    errorCallbackFunction(code, description);
}

static GLFWerrorfun glfwSetErrorCallback(function<void(int code, const char* description)> callback) {
    errorCallbackFunction = callback;
    return glfwSetErrorCallback(errorCallbackFunctionHelper);
}

static void keyCallbackFunctionHelper(GLFWwindow* window, int key, int scancode, int action, int mods) {
    keyCallbackFunction[window](window, key, scancode, action, mods);
}

static GLFWkeyfun glfwSetKeyCallback(GLFWwindow* window, function<void(GLFWwindow* window, int key, int scancode, int action, int mods)> callback) {
    keyCallbackFunction[window] = callback;
    return glfwSetKeyCallback(window, keyCallbackFunctionHelper);
}

static void charCallbackFunctionHelper(GLFWwindow* window, unsigned int codepoint) {
    charCallbackFunction[window](window, codepoint);
}

static GLFWcharfun glfwSetCharCallback(GLFWwindow* window, function<void(GLFWwindow* window, unsigned int codepoint)> callback) {
    charCallbackFunction[window] = callback;
    return glfwSetCharCallback(window, charCallbackFunctionHelper);
}

static void charModsCallbackFunctionHelper(GLFWwindow* window, unsigned int codepoint, int mods) {
    charModsCallbackFunction[window](window, codepoint, mods);
}

static GLFWcharmodsfun glfwSetCharModsCallback(GLFWwindow* window, function<void(GLFWwindow* window, unsigned int codepoint, int mods)> callback) {
    charModsCallbackFunction[window] = callback;
    return glfwSetCharModsCallback(window, charModsCallbackFunctionHelper);
}

static void mouseButtonCallbackFunctionHelper(GLFWwindow* window, int button, int action, int mods) {
    mouseButtonCallbackFunction[window](window, button, action, mods);
}

static GLFWmousebuttonfun glfwSetMouseButtonCallback(GLFWwindow* window, function<void(GLFWwindow* window, int button, int action, int mods)> callback) {
    mouseButtonCallbackFunction[window] = callback;
    return glfwSetMouseButtonCallback(window, mouseButtonCallbackFunctionHelper);
}

static void cursorPosCallbackFunctionHelper(GLFWwindow* window, double xpos, double ypos) {
    cursorPosCallbackFunction[window](window, xpos, ypos);
}

static GLFWcursorposfun glfwSetCursorPosCallback(GLFWwindow* window, function<void(GLFWwindow* window, double xpos, double ypos)> callback) {
    cursorPosCallbackFunction[window] = callback;
    return glfwSetCursorPosCallback(window, cursorPosCallbackFunctionHelper);
}

static void cursorEnterCallbackFunctionHelper(GLFWwindow* window, int entered) {
    cursorEnterCallbackFunction[window](window, entered);
}

static GLFWcursorenterfun glfwSetCursorEnterCallback(GLFWwindow* window, function<void(GLFWwindow* window, int entered)> callback) {
    cursorEnterCallbackFunction[window] = callback;
    return glfwSetCursorEnterCallback(window, cursorEnterCallbackFunctionHelper);
}

static void scrollCallbackFunctionHelper(GLFWwindow* window, double xoffset, double yoffset) {
    scrollCallbackFunction[window](window, xoffset, yoffset);
}

static GLFWscrollfun glfwSetScrollCallback(GLFWwindow* window, function<void(GLFWwindow* window, double xoffset, double yoffset)> callback) {
    scrollCallbackFunction[window] = callback;
    return glfwSetScrollCallback(window, scrollCallbackFunctionHelper);
}

static void dropCallbackFunctionHelper(GLFWwindow* window, int pathCount, const char* paths[]) {
    dropCallbackFunction[window](window, pathCount, paths);
}

static GLFWdropfun glfwSetDropCallback(GLFWwindow* window, function<void(GLFWwindow* window, int pathCount, const char* paths[])> callback) {
    dropCallbackFunction[window] = callback;
    return glfwSetDropCallback(window, dropCallbackFunctionHelper);
}

static void joystickCallbackFunctionHelper(int jid, int event) {
    joystickCallbackFunction(jid, event);
}

static GLFWjoystickfun glfwSetJoystickCallback(function<void(int jid, int event)> callback) {
    joystickCallbackFunction = callback;
    return glfwSetJoystickCallback(joystickCallbackFunctionHelper);
}

static void monitorCallbackFunctionHelper(GLFWmonitor* monitor, int event) {
    monitorCallbackFunction(monitor, event);
}

static GLFWmonitorfun glfwSetMonitorCallback(function<void(GLFWmonitor* monitor, int event)> callback) {
    monitorCallbackFunction = callback;
    return glfwSetMonitorCallback(monitorCallbackFunctionHelper);
}

static void windowPosCallbackFunctionHelper(GLFWwindow* window, int xpos, int ypos) {
    windowPosCallbackFunction[window](window, xpos, ypos);
}

static GLFWwindowposfun glfwSetWindowPosCallback(GLFWwindow* window, function<void(GLFWwindow* window, int xpos, int ypos)> callback) {
    windowPosCallbackFunction[window] = callback;
    return glfwSetWindowPosCallback(window, windowPosCallbackFunctionHelper);
}

static void windowSizeCallbackFunctionHelper(GLFWwindow* window, int width, int height) {
    windowSizeCallbackFunction[window](window, width, height);
}

static GLFWwindowsizefun glfwSetWindowSizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int width, int height)> callback) {
    windowSizeCallbackFunction[window] = callback;
    return glfwSetWindowSizeCallback(window, windowSizeCallbackFunctionHelper);
}

static void windowCloseCallbackFunctionHelper(GLFWwindow* window) {
    windowCloseCallbackFunction[window](window);
}

static GLFWwindowclosefun glfwSetWindowCloseCallback(GLFWwindow* window, function<void(GLFWwindow* window)> callback) {
    windowCloseCallbackFunction[window] = callback;
    return glfwSetWindowCloseCallback(window, windowCloseCallbackFunctionHelper);
}

static void windowRefreshCallbackFunctionHelper(GLFWwindow* window) {
    windowRefreshCallbackFunction[window](window);
}

static GLFWwindowrefreshfun glfwSetWindowRefreshCallback(GLFWwindow* window, function<void(GLFWwindow* window)> callback) {
    windowRefreshCallbackFunction[window] = callback;
    return glfwSetWindowRefreshCallback(window, windowRefreshCallbackFunctionHelper);
}

static void windowFocusCallbackFunctionHelper(GLFWwindow* window, int focused) {
    windowFocusCallbackFunction[window](window, focused);
}

static GLFWwindowfocusfun glfwSetWindowFocusCallback(GLFWwindow* window, function<void(GLFWwindow* window, int focused)> callback) {
    windowFocusCallbackFunction[window] = callback;
    return glfwSetWindowFocusCallback(window, windowFocusCallbackFunctionHelper);
}

static void windowIconifyCallbackFunctionHelper(GLFWwindow* window, int iconified) {
    windowIconifyCallbackFunction[window](window, iconified);
}

static GLFWwindowiconifyfun glfwSetWindowIconifyCallback(GLFWwindow* window, function<void(GLFWwindow* window, int iconified)> callback) {
    windowIconifyCallbackFunction[window] = callback;
    return glfwSetWindowIconifyCallback(window, windowIconifyCallbackFunctionHelper);
}

static void windowMaximizeCallbackFunctionHelper(GLFWwindow* window, int maximized) {
    windowMaximizeCallbackFunction[window](window, maximized);
}

static GLFWwindowmaximizefun glfwSetWindowMaximizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int maximized)> callback) {
    windowMaximizeCallbackFunction[window] = callback;
    return glfwSetWindowMaximizeCallback(window, windowMaximizeCallbackFunctionHelper);
}

static void framebufferSizeCallbackFunctionHelper(GLFWwindow* window, int width, int height) {
    framebufferSizeCallbackFunction[window](window, width, height);
}

static GLFWframebuffersizefun glfwSetFramebufferSizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int width, int height)> callback) {
    framebufferSizeCallbackFunction[window] = callback;
    return glfwSetFramebufferSizeCallback(window, framebufferSizeCallbackFunctionHelper);
}

static void windowContentScaleCallbackFunctionHelper(GLFWwindow* window, float xscale, float yscale) {
    windowContentScaleCallbackFunction[window](window, xscale, yscale);
}

static GLFWwindowcontentscalefun glfwSetWindowContentScaleCallback(GLFWwindow* window, function<void(GLFWwindow* window, float xscale, float yscale)> callback) {
    windowContentScaleCallbackFunction[window] = callback;
    return glfwSetWindowContentScaleCallback(window, windowContentScaleCallbackFunctionHelper);
}

class MexFunction : public Function 
{
private:
    ArrayFactory factory;
    shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();
public:
    ~MexFunction()
    {
        glfwSetErrorCallback(nullptr);
        glfwSetJoystickCallback(nullptr);
        glfwSetMonitorCallback(nullptr);
        glfwTerminate(); // easiest way to remove all window callbacks
        errorCallbackFunction = nullptr;
        keyCallbackFunction.clear();
        charCallbackFunction.clear();
        charModsCallbackFunction.clear();
        mouseButtonCallbackFunction.clear();
        cursorPosCallbackFunction.clear();
        cursorEnterCallbackFunction.clear();
        scrollCallbackFunction.clear();
        dropCallbackFunction.clear();
        joystickCallbackFunction = nullptr;
        monitorCallbackFunction = nullptr;
        windowPosCallbackFunction.clear();
        windowSizeCallbackFunction.clear();
        windowCloseCallbackFunction.clear();
        windowRefreshCallbackFunction.clear();
        windowFocusCallbackFunction.clear();
        windowIconifyCallbackFunction.clear();
        windowMaximizeCallbackFunction.clear();
        framebufferSizeCallbackFunction.clear();
        windowContentScaleCallbackFunction.clear();
    }

    void operator()(ArgumentList outputs, ArgumentList inputs) 
    {
        if (inputs.size() < 2 || outputs.size() > 1)
            error("GLFW:registerCallback:usage", 
            "Usage: previousCallback = glfwRegisterCallback(type, arg1, ..., argN)");

        string type = parseType(inputs[0]);
        intptr_t previousCallback;
        
        if (type == "error")
        {
            GLFWerrorfun pc;
            if (inputs[1].isEmpty()) 
            {
                pc = glfwSetErrorCallback(nullptr);
                errorCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(int code, const char* description)> lambdaCallback = [=](int code, const char* description) {
                    fevalAsync({callback, factory.createScalar(code), factory.createScalar(description)});
                };
                pc = glfwSetErrorCallback(lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "key")
        {
            GLFWkeyfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetKeyCallback(window, nullptr);
                keyCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int key, int scancode, int action, int mods)> lambdaCallback = [=](GLFWwindow* window, int key, int scancode, int action, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(key), factory.createScalar(scancode), factory.createScalar(action), factory.createScalar(mods)});
                };
                pc = glfwSetKeyCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "char")
        {
            GLFWcharfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetCharCallback(window, nullptr);
                charCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, unsigned int codepoint)> lambdaCallback = [=](GLFWwindow* window, unsigned int codepoint) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(codepoint)});
                };
                pc = glfwSetCharCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "charMods")
        {
            GLFWcharmodsfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetCharModsCallback(window, nullptr);
                charModsCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, unsigned int codepoint, int mods)> lambdaCallback = [=](GLFWwindow* window, unsigned int codepoint, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(codepoint), factory.createScalar(mods)});
                };
                pc = glfwSetCharModsCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "mouseButton")
        {
            GLFWmousebuttonfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetMouseButtonCallback(window, nullptr);
                mouseButtonCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int button, int action, int mods)> lambdaCallback = [=](GLFWwindow* window, int button, int action, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(button), factory.createScalar(action), factory.createScalar(mods)});
                };
                pc = glfwSetMouseButtonCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "cursorPos")
        {
            GLFWcursorposfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetCursorPosCallback(window, nullptr);
                cursorPosCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, double xpos, double ypos)> lambdaCallback = [=](GLFWwindow* window, double xpos, double ypos) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xpos), factory.createScalar(ypos)});
                };
                pc = glfwSetCursorPosCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "cursorEnter")
        {
            GLFWcursorenterfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetCursorEnterCallback(window, nullptr);
                cursorEnterCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int entered)> lambdaCallback = [=](GLFWwindow* window, int entered) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(entered)});
                };
                pc = glfwSetCursorEnterCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "scroll")
        {
            GLFWscrollfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetScrollCallback(window, nullptr);
                scrollCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, double xoffset, double yoffset)> lambdaCallback = [=](GLFWwindow* window, double xoffset, double yoffset) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xoffset), factory.createScalar(yoffset)});
                };
                pc = glfwSetScrollCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "drop")
        {
            GLFWdropfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetDropCallback(window, nullptr);
                dropCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int pathCount, const char* paths[])> lambdaCallback = [=](GLFWwindow* window, int pathCount, const char* paths[]) {
                    StringArray pathArray = factory.createArray<MATLABString>({1,(uint)pathCount});
                    for (size_t i = 0; i < pathCount; i++) {
                        pathArray[i] = paths[i];
                    }
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(pathCount), pathArray});
                };
                pc = glfwSetDropCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "joystick")
        {
            GLFWjoystickfun pc;
            if (inputs[1].isEmpty()) 
            {
                pc = glfwSetJoystickCallback(nullptr);
                joystickCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(int jid, int event)> lambdaCallback = [=](int jid, int event) {
                    fevalAsync({callback, factory.createScalar(jid), factory.createScalar(event)});
                };
                pc = glfwSetJoystickCallback(lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "monitor")
        {
            GLFWmonitorfun pc;
            if (inputs[1].isEmpty()) 
            {
                pc = glfwSetMonitorCallback(nullptr);
                monitorCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(GLFWmonitor* monitor, int event)> lambdaCallback = [=](GLFWmonitor* monitor, int event) {
                    fevalAsync({callback, factory.createScalar((int64_t)monitor), factory.createScalar(event)});
                };
                pc = glfwSetMonitorCallback(lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowPos")
        {
            GLFWwindowposfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowPosCallback(window, nullptr);
                windowPosCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int xpos, int ypos)> lambdaCallback = [=](GLFWwindow* window, int xpos, int ypos) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xpos), factory.createScalar(ypos)});
                };
                pc = glfwSetWindowPosCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowSize")
        {
            GLFWwindowsizefun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowSizeCallback(window, nullptr);
                windowSizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int width, int height)> lambdaCallback = [=](GLFWwindow* window, int width, int height) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(width), factory.createScalar(height)});
                };
                pc = glfwSetWindowSizeCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowClose")
        {
            GLFWwindowclosefun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowCloseCallback(window, nullptr);
                windowCloseCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window)> lambdaCallback = [=](GLFWwindow* window) {
                    fevalAsync({callback, factory.createScalar((int64_t)window)});
                };
                pc = glfwSetWindowCloseCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowRefresh")
        {
            GLFWwindowrefreshfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowRefreshCallback(window, nullptr);
                windowRefreshCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window)> lambdaCallback = [=](GLFWwindow* window) {
                    fevalAsync({callback, factory.createScalar((int64_t)window)});
                };
                pc = glfwSetWindowRefreshCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowFocus")
        {
            GLFWwindowfocusfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowFocusCallback(window, nullptr);
                windowFocusCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int focused)> lambdaCallback = [=](GLFWwindow* window, int focused) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(focused)});
                };
                pc = glfwSetWindowFocusCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowIconify")
        {
            GLFWwindowiconifyfun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowIconifyCallback(window, nullptr);
                windowIconifyCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int iconified)> lambdaCallback = [=](GLFWwindow* window, int iconified) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(iconified)});
                };
                pc = glfwSetWindowIconifyCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowMaximize")
        {
            GLFWwindowmaximizefun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowMaximizeCallback(window, nullptr);
                windowMaximizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int maximized)> lambdaCallback = [=](GLFWwindow* window, int maximized) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(maximized)});
                };
                pc = glfwSetWindowMaximizeCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "framebufferSize")
        {
            GLFWframebuffersizefun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetFramebufferSizeCallback(window, nullptr);
                framebufferSizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int width, int height)> lambdaCallback = [=](GLFWwindow* window, int width, int height) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(width), factory.createScalar(height)});
                };
                pc = glfwSetFramebufferSizeCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else if (type == "windowContentScale")
        {
            GLFWwindowcontentscalefun pc;
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                pc = glfwSetWindowContentScaleCallback(window, nullptr);
                windowContentScaleCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, float xscale, float yscale)> lambdaCallback = [=](GLFWwindow* window, float xscale, float yscale) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xscale), factory.createScalar(yscale)});
                };
                pc = glfwSetWindowContentScaleCallback(window, lambdaCallback);
            }
            previousCallback = (intptr_t)pc;
        }
        else
        {
            error("GLFW:registerCallback:unknownType",
            "Unknown callback type");           
        }

        outputs[0] = factory.createScalar<int64_t>(previousCallback);
    }

    string parseType(Array& array)
    {
        if (array.getType() != ArrayType::MATLAB_STRING || array.getNumberOfElements() != 1)
            error("GLFW:registerCallback:invalidType",
            "Type must be a string scalar.");

        StringArray typeArray = array;
        return (string)typeArray[0];
    }

    GLFWwindow* parseWindow(Array& array)
    {
        if (array.getType() != ArrayType::INT64 || array.getType() == ArrayType::COMPLEX_INT64 || array.getNumberOfElements() != 1)
            error("GLFW:registerCallback:invalidWindow",
            "Window must be a int64 scalar (encoded pointer).");

        TypedArray<int64_t> windowArray = array;
        intptr_t windowPtr = array[0];
        return (GLFWwindow*)windowPtr;
    }

    ObjectArray parseCallback(Array& array)
    {
        if (array.getType() != ArrayType::HANDLE_OBJECT_REF)
            error("GLFW:registerCallback:invalidCallback",
            "Callback must be a function handle or empty.");

        return array;
    }

    void fevalAsync(const vector<Array>& args)
    {
        matlabPtr->fevalAsync(u"feval", 0, args);
    }

    void error(string id, string message)
    {
        ArrayFactory factory;
        matlabPtr->feval(u"error", 0, vector<Array>({
            factory.createScalar(id),
            factory.createScalar(message)}));
    }
};