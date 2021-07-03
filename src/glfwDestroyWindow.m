function glfwDestroyWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwDestroyWindow", window);
end