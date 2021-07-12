function monitor = glfwGetPrimaryMonitor()
monitor = calllibglfw("glfwGetPrimaryMonitor");
monitor = GLFWmonitor(monitor);
end