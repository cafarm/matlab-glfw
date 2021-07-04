function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
ramp = calllibglfw("glfwGetGammaRamp", monitor);
end
