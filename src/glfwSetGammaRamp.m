function [monitor, ramp] = glfwSetGammaRamp(monitor, ramp)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
    ramp (1,1) {mustBeLibPointer(ramp,"GLFWgammarampPtr"), mustBeNonnull}
end
calllibglfw("glfwSetGammaRamp", monitor, ramp);
end
