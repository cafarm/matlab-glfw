function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
end
ramp = calllibglfw("glfwGetGammaRamp", monitor);
end
