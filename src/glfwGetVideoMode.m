function mode = glfwGetVideoMode(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
pmode = calllibglfw("glfwGetVideoMode", monitor);
if isNull(pmode)
    [code,desc] = glfwGetError();
    error("GLFW:getVideoMode:error", "Unable to get video mode (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
mode = pmode.Value;
end
