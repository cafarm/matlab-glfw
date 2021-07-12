function window = glfwGetCurrentContext()
window = calllibglfw("glfwGetCurrentContext");
window = GLFWwindow(window);
end
