function mode = glfwGetVideoMode(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
end
mode = calllibglfw("glfwGetVideoMode", monitor);
end
