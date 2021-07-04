function flag = glfwWindowShouldClose(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
flag = calllibglfw("glfwWindowShouldClose", window);
flag = double(flag);
end