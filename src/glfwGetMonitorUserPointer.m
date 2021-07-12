function pointer = glfwGetMonitorUserPointer(monitor)
arguments
    monitor (1,1) {mustBeA(monitor,"GLFWmonitor"), mustBeNonnull}
end
pointer = calllibglfw("glfwGetMonitorUserPointer", libpointer(monitor));
end
