function flag = glfwWindowShouldClose(window)
arguments
    window (1,1) {mustBeLibPointer}
end
flag = calllibglfw("glfwWindowShouldClose", window);
flag = double(flag);
end