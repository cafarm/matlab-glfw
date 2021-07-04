function glfwShowWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwShowWindow", window);
end
