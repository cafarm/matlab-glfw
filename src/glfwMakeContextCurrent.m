function glfwMakeContextCurrent(window)

calllib("libglfw", "glfwMakeContextCurrent", window);
end