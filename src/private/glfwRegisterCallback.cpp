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

static void glfwSetErrorCallback(function<void(int code, const char* description)> callback) {
    errorCallbackFunction = callback;
    glfwSetErrorCallback(errorCallbackFunctionHelper);
}

static void keyCallbackFunctionHelper(GLFWwindow* window, int key, int scancode, int action, int mods) {
    keyCallbackFunction[window](window, key, scancode, action, mods);
}

static void glfwSetKeyCallback(GLFWwindow* window, function<void(GLFWwindow* window, int key, int scancode, int action, int mods)> callback) {
    keyCallbackFunction[window] = callback;
    glfwSetKeyCallback(window, keyCallbackFunctionHelper);
}

static void charCallbackFunctionHelper(GLFWwindow* window, unsigned int codepoint) {
    charCallbackFunction[window](window, codepoint);
}

static void glfwSetCharCallback(GLFWwindow* window, function<void(GLFWwindow* window, unsigned int codepoint)> callback) {
    charCallbackFunction[window] = callback;
    glfwSetCharCallback(window, charCallbackFunctionHelper);
}

static void charModsCallbackFunctionHelper(GLFWwindow* window, unsigned int codepoint, int mods) {
    charModsCallbackFunction[window](window, codepoint, mods);
}

static void glfwSetCharModsCallback(GLFWwindow* window, function<void(GLFWwindow* window, unsigned int codepoint, int mods)> callback) {
    charModsCallbackFunction[window] = callback;
    glfwSetCharModsCallback(window, charModsCallbackFunctionHelper);
}

static void mouseButtonCallbackFunctionHelper(GLFWwindow* window, int button, int action, int mods) {
    mouseButtonCallbackFunction[window](window, button, action, mods);
}

static void glfwSetMouseButtonCallback(GLFWwindow* window, function<void(GLFWwindow* window, int button, int action, int mods)> callback) {
    mouseButtonCallbackFunction[window] = callback;
    glfwSetMouseButtonCallback(window, mouseButtonCallbackFunctionHelper);
}

static void cursorPosCallbackFunctionHelper(GLFWwindow* window, double xpos, double ypos) {
    cursorPosCallbackFunction[window](window, xpos, ypos);
}

static void glfwSetCursorPosCallback(GLFWwindow* window, function<void(GLFWwindow* window, double xpos, double ypos)> callback) {
    cursorPosCallbackFunction[window] = callback;
    glfwSetCursorPosCallback(window, cursorPosCallbackFunctionHelper);
}

static void cursorEnterCallbackFunctionHelper(GLFWwindow* window, int entered) {
    cursorEnterCallbackFunction[window](window, entered);
}

static void glfwSetCursorEnterCallback(GLFWwindow* window, function<void(GLFWwindow* window, int entered)> callback) {
    cursorEnterCallbackFunction[window] = callback;
    glfwSetCursorEnterCallback(window, cursorEnterCallbackFunctionHelper);
}

static void scrollCallbackFunctionHelper(GLFWwindow* window, double xoffset, double yoffset) {
    scrollCallbackFunction[window](window, xoffset, yoffset);
}

static void glfwSetScrollCallback(GLFWwindow* window, function<void(GLFWwindow* window, double xoffset, double yoffset)> callback) {
    scrollCallbackFunction[window] = callback;
    glfwSetScrollCallback(window, scrollCallbackFunctionHelper);
}

static void dropCallbackFunctionHelper(GLFWwindow* window, int pathCount, const char* paths[]) {
    dropCallbackFunction[window](window, pathCount, paths);
}

static void glfwSetDropCallback(GLFWwindow* window, function<void(GLFWwindow* window, int pathCount, const char* paths[])> callback) {
    dropCallbackFunction[window] = callback;
    glfwSetDropCallback(window, dropCallbackFunctionHelper);
}

static void joystickCallbackFunctionHelper(int jid, int event) {
    joystickCallbackFunction(jid, event);
}

static void glfwSetJoystickCallback(function<void(int jid, int event)> callback) {
    joystickCallbackFunction = callback;
    glfwSetJoystickCallback(joystickCallbackFunctionHelper);
}

static void monitorCallbackFunctionHelper(GLFWmonitor* monitor, int event) {
    monitorCallbackFunction(monitor, event);
}

static void glfwSetMonitorCallback(function<void(GLFWmonitor* monitor, int event)> callback) {
    monitorCallbackFunction = callback;
    glfwSetMonitorCallback(monitorCallbackFunctionHelper);
}

static void windowPosCallbackFunctionHelper(GLFWwindow* window, int xpos, int ypos) {
    windowPosCallbackFunction[window](window, xpos, ypos);
}

static void glfwSetWindowPosCallback(GLFWwindow* window, function<void(GLFWwindow* window, int xpos, int ypos)> callback) {
    windowPosCallbackFunction[window] = callback;
    glfwSetWindowPosCallback(window, windowPosCallbackFunctionHelper);
}

static void windowSizeCallbackFunctionHelper(GLFWwindow* window, int width, int height) {
    windowSizeCallbackFunction[window](window, width, height);
}

static void glfwSetWindowSizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int width, int height)> callback) {
    windowSizeCallbackFunction[window] = callback;
    glfwSetWindowSizeCallback(window, windowSizeCallbackFunctionHelper);
}

static void windowCloseCallbackFunctionHelper(GLFWwindow* window) {
    windowCloseCallbackFunction[window](window);
}

static void glfwSetWindowCloseCallback(GLFWwindow* window, function<void(GLFWwindow* window)> callback) {
    windowCloseCallbackFunction[window] = callback;
    glfwSetWindowCloseCallback(window, windowCloseCallbackFunctionHelper);
}

static void windowRefreshCallbackFunctionHelper(GLFWwindow* window) {
    windowRefreshCallbackFunction[window](window);
}

static void glfwSetWindowRefreshCallback(GLFWwindow* window, function<void(GLFWwindow* window)> callback) {
    windowRefreshCallbackFunction[window] = callback;
    glfwSetWindowRefreshCallback(window, windowRefreshCallbackFunctionHelper);
}

static void windowFocusCallbackFunctionHelper(GLFWwindow* window, int focused) {
    windowFocusCallbackFunction[window](window, focused);
}

static void glfwSetWindowFocusCallback(GLFWwindow* window, function<void(GLFWwindow* window, int focused)> callback) {
    windowFocusCallbackFunction[window] = callback;
    glfwSetWindowFocusCallback(window, windowFocusCallbackFunctionHelper);
}

static void windowIconifyCallbackFunctionHelper(GLFWwindow* window, int iconified) {
    windowIconifyCallbackFunction[window](window, iconified);
}

static void glfwSetWindowIconifyCallback(GLFWwindow* window, function<void(GLFWwindow* window, int iconified)> callback) {
    windowIconifyCallbackFunction[window] = callback;
    glfwSetWindowIconifyCallback(window, windowIconifyCallbackFunctionHelper);
}

static void windowMaximizeCallbackFunctionHelper(GLFWwindow* window, int maximized) {
    windowMaximizeCallbackFunction[window](window, maximized);
}

static void glfwSetWindowMaximizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int maximized)> callback) {
    windowMaximizeCallbackFunction[window] = callback;
    glfwSetWindowMaximizeCallback(window, windowMaximizeCallbackFunctionHelper);
}

static void framebufferSizeCallbackFunctionHelper(GLFWwindow* window, int width, int height) {
    framebufferSizeCallbackFunction[window](window, width, height);
}

static void glfwSetFramebufferSizeCallback(GLFWwindow* window, function<void(GLFWwindow* window, int width, int height)> callback) {
    framebufferSizeCallbackFunction[window] = callback;
    glfwSetFramebufferSizeCallback(window, framebufferSizeCallbackFunctionHelper);
}

static void windowContentScaleCallbackFunctionHelper(GLFWwindow* window, float xscale, float yscale) {
    windowContentScaleCallbackFunction[window](window, xscale, yscale);
}

static void glfwSetWindowContentScaleCallback(GLFWwindow* window, function<void(GLFWwindow* window, float xscale, float yscale)> callback) {
    windowContentScaleCallbackFunction[window] = callback;
    glfwSetWindowContentScaleCallback(window, windowContentScaleCallbackFunctionHelper);
}

class MexFunction : public Function 
{
private:
    ArrayFactory factory;
    shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();
public:
    ~MexFunction()
    {
        glfwTerminate(); // easiest way to remove all callbacks
        errorCallbackFunction = nullptr;
        cursorEnterCallbackFunction.clear();
    }

    void operator()(ArgumentList outputs, ArgumentList inputs) 
    {
        if (inputs.size() < 2)
            error("GLFW:registerCallback:usage", 
            "Usage: glfwRegisterCallback(type, arg1, ..., argN)");

        string type = parseType(inputs[0]);
        
        if (type == "error")
        {
            if (inputs[1].isEmpty()) 
            {
                glfwSetErrorCallback(nullptr);
                errorCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(int code, const char* description)> lambdaCallback = [=](int code, const char* description) {
                    fevalAsync({callback, factory.createScalar(code), factory.createScalar(description)});
                };
                glfwSetErrorCallback(lambdaCallback);
            }
        }
        else if (type == "char")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetCharCallback(window, nullptr);
                charCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, unsigned int codepoint)> lambdaCallback = [=](GLFWwindow* window, unsigned int codepoint) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(codepoint)});
                };
                glfwSetCharCallback(window, lambdaCallback);
            }
        }
        else if (type == "key")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetKeyCallback(window, nullptr);
                keyCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int key, int scancode, int action, int mods)> lambdaCallback = [=](GLFWwindow* window, int key, int scancode, int action, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(key), factory.createScalar(scancode), factory.createScalar(action), factory.createScalar(mods)});
                };
                glfwSetKeyCallback(window, lambdaCallback);
            }
        }
        else if (type == "charMods")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetCharModsCallback(window, nullptr);
                charModsCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, unsigned int codepoint, int mods)> lambdaCallback = [=](GLFWwindow* window, unsigned int codepoint, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(codepoint), factory.createScalar(mods)});
                };
                glfwSetCharModsCallback(window, lambdaCallback);
            }
        }
        else if (type == "mouseButton")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetMouseButtonCallback(window, nullptr);
                mouseButtonCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int button, int action, int mods)> lambdaCallback = [=](GLFWwindow* window, int button, int action, int mods) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(button), factory.createScalar(action), factory.createScalar(mods)});
                };
                glfwSetMouseButtonCallback(window, lambdaCallback);
            }
        }
        else if (type == "cursorPos")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetCursorPosCallback(window, nullptr);
                cursorPosCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, double xpos, double ypos)> lambdaCallback = [=](GLFWwindow* window, double xpos, double ypos) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xpos), factory.createScalar(ypos)});
                };
                glfwSetCursorPosCallback(window, lambdaCallback);
            }
        }
        else if (type == "cursorEnter")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetCursorEnterCallback(window, nullptr);
                cursorEnterCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int entered)> lambdaCallback = [=](GLFWwindow* window, int entered) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(entered)});
                };
                glfwSetCursorEnterCallback(window, lambdaCallback);
            }
        }
        else if (type == "scroll")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetScrollCallback(window, nullptr);
                scrollCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, double xoffset, double yoffset)> lambdaCallback = [=](GLFWwindow* window, double xoffset, double yoffset) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xoffset), factory.createScalar(yoffset)});
                };
                glfwSetScrollCallback(window, lambdaCallback);
            }
        }
        else if (type == "drop")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetDropCallback(window, nullptr);
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
                glfwSetDropCallback(window, lambdaCallback);
            }
        }
        else if (type == "joystick")
        {
            if (inputs[1].isEmpty()) 
            {
                glfwSetJoystickCallback(nullptr);
                joystickCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(int jid, int event)> lambdaCallback = [=](int jid, int event) {
                    fevalAsync({callback, factory.createScalar(jid), factory.createScalar(event)});
                };
                glfwSetJoystickCallback(lambdaCallback);
            }
        }
        else if (type == "monitor")
        {
            if (inputs[1].isEmpty()) 
            {
                glfwSetMonitorCallback(nullptr);
                monitorCallbackFunction = nullptr;
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[1]);
                function<void(GLFWmonitor* monitor, int event)> lambdaCallback = [=](GLFWmonitor* monitor, int event) {
                    fevalAsync({callback, factory.createScalar((int64_t)monitor), factory.createScalar(event)});
                };
                glfwSetMonitorCallback(lambdaCallback);
            }
        }
        else if (type == "windowPos")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowPosCallback(window, nullptr);
                windowPosCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int xpos, int ypos)> lambdaCallback = [=](GLFWwindow* window, int xpos, int ypos) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xpos), factory.createScalar(ypos)});
                };
                glfwSetWindowPosCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowSize")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowSizeCallback(window, nullptr);
                windowSizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int width, int height)> lambdaCallback = [=](GLFWwindow* window, int width, int height) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(width), factory.createScalar(height)});
                };
                glfwSetWindowSizeCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowClose")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowCloseCallback(window, nullptr);
                windowCloseCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window)> lambdaCallback = [=](GLFWwindow* window) {
                    fevalAsync({callback, factory.createScalar((int64_t)window)});
                };
                glfwSetWindowCloseCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowRefresh")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowRefreshCallback(window, nullptr);
                windowRefreshCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window)> lambdaCallback = [=](GLFWwindow* window) {
                    fevalAsync({callback, factory.createScalar((int64_t)window)});
                };
                glfwSetWindowRefreshCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowFocus")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowFocusCallback(window, nullptr);
                windowFocusCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int focused)> lambdaCallback = [=](GLFWwindow* window, int focused) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(focused)});
                };
                glfwSetWindowFocusCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowIconify")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowIconifyCallback(window, nullptr);
                windowIconifyCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int iconified)> lambdaCallback = [=](GLFWwindow* window, int iconified) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(iconified)});
                };
                glfwSetWindowIconifyCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowMaximize")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowMaximizeCallback(window, nullptr);
                windowMaximizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int maximized)> lambdaCallback = [=](GLFWwindow* window, int maximized) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(maximized)});
                };
                glfwSetWindowMaximizeCallback(window, lambdaCallback);
            }
        }
        else if (type == "framebufferSize")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetFramebufferSizeCallback(window, nullptr);
                framebufferSizeCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, int width, int height)> lambdaCallback = [=](GLFWwindow* window, int width, int height) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(width), factory.createScalar(height)});
                };
                glfwSetFramebufferSizeCallback(window, lambdaCallback);
            }
        }
        else if (type == "windowContentScale")
        {
            GLFWwindow* window = parseWindow(inputs[1]);
            if (inputs[2].isEmpty()) 
            {
                glfwSetWindowContentScaleCallback(window, nullptr);
                windowContentScaleCallbackFunction.erase(window);
            }
            else
            {
                ObjectArray callback = parseCallback(inputs[2]);
                function<void(GLFWwindow* window, float xscale, float yscale)> lambdaCallback = [=](GLFWwindow* window, float xscale, float yscale) {
                    fevalAsync({callback, factory.createScalar((int64_t)window), factory.createScalar(xscale), factory.createScalar(yscale)});
                };
                glfwSetWindowContentScaleCallback(window, lambdaCallback);
            }
        }
        else
        {
            error("GLFW:registerCallback:unknownType",
            "Unknown callback type");           
        }
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