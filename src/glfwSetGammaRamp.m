function glfwSetGammaRamp(monitor, ramp)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
    ramp (1,1) {mustBeClass(ramp,"GLFWgammaramp")}
end
validate(ramp);
calllibglfw("glfwSetGammaRamp", libpointer(monitor), libpointer(ramp));
end