function mode = glfwGetVideoMode(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
modePtr = calllibglfw("glfwGetVideoMode", libpointer(monitor));
if isNull(modePtr)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getVideoMode:" + id, "Unable to get video mode (%s). %s", id, strjoin(desc, "."));
end
mode = GLFWvidmode.fromLibPointer(modePtr);
end
