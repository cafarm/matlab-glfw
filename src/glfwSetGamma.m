function glfwSetGamma(monitor, gamma)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
    gamma (1,1) single
end
calllibglfw("glfwSetGamma", monitor, gamma);
end
