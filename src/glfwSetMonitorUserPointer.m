function glfwSetMonitorUserPointer(monitor, pointer)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
    pointer (1,1) {mustBeLibPointer}
end
calllibglfw("glfwSetMonitorUserPointer", monitor, pointer);
end
