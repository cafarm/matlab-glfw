function glfwSetGamma(monitor, gamma)
arguments
    monitor (1,1) {mustBeA(monitor,"GLFWmonitor"), mustBeNonnull}
    gamma (1,1) single
end
calllibglfw("glfwSetGamma", libpointer(monitor), gamma);
end
