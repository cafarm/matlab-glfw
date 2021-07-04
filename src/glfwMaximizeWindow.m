function glfwMaximizeWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwMaximizeWindow", window);
end
