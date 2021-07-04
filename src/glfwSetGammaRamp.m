function [monitor, ramp] = glfwSetGammaRamp(monitor, ramp)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
    ramp (1,1) {mustBeLibPointer(ramp,"GLFWgammarampPtr")}
end
calllibglfw("glfwSetGammaRamp", monitor, ramp);
end
