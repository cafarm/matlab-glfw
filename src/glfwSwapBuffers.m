function glfwSwapBuffers(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwSwapBuffers", window);
end