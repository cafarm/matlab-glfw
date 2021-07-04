function name = glfwGetMonitorName(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
name = calllibglfw("glfwGetMonitorName", monitor);
name = string(name);
end
