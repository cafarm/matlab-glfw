function glfwSetMonitorUserPointer(monitor, pointer)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
    pointer (1,1) {mustBeLibPointer}
end
calllibglfw("glfwSetMonitorUserPointer", libpointer(monitor), pointer);
end
