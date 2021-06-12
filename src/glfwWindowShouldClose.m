function flag = glfwWindowShouldClose(window)
arguments
    window (1,1) {mustBeLibPointer}
end
flag = calllib("libglfw", "glfwWindowShouldClose", window);
end