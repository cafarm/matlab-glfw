function name = glfwGetMonitorName(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
name = calllibglfw("glfwGetMonitorName", libpointer(monitor));
name = string(name);
end
