function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
ramp = calllibglfw("glfwGetGammaRamp", monitor);
end
