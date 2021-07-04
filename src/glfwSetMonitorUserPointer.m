function glfwSetMonitorUserPointer(monitor, pointer)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
    pointer (1,1) {mustBeLibPointer(pointer,"voidPtr")}
end
calllibglfw("glfwSetMonitorUserPointer", monitor, pointer);
end
