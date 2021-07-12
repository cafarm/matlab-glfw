function flag = glfwWindowShouldClose(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
flag = calllibglfw("glfwWindowShouldClose", libpointer(window));
flag = double(flag);
end