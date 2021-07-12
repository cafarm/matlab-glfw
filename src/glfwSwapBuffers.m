function glfwSwapBuffers(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwSwapBuffers", libpointer(window));
end