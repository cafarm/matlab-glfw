function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
rampPtr = calllibglfw("glfwGetGammaRamp", libpointer(monitor));
if isNull(rampPtr)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getGammaRamp:" + id, "Unable to get gamma ramp (%s). %s", id, strjoin(desc, "."));
end
ramp = GLFWgammaramp.fromLibPointer(rampPtr);
end
