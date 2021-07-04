function pointer = glfwGetMonitorUserPointer(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
end
pointer = calllibglfw("glfwGetMonitorUserPointer", monitor);
end
