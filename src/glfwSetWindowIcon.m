function glfwSetWindowIcon(window, image)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow")}
    image (1,1) {mustBeClass(image,"GLFWimage")}
end
validate(image);
calllibglfw("glfwSetWindowIcon", libpointer(window), 1, libpointer(image));
end
