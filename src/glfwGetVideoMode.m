function mode = glfwGetVideoMode(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
pmode = calllibglfw("glfwGetVideoMode", monitor);
if isNull(pmode)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getVideoMode:" + id, "Unable to get video mode (%s). %s", id, strjoin(desc, "."));
end
mode = pmode.Value;
end
