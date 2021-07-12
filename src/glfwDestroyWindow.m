function glfwDestroyWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow")}
end
calllibglfw("glfwDestroyWindow", libpointer(window));
delete(window);
end