function glfwTerminate()
calllib("libglfw", "glfwTerminate");
unloadlibrary("libglfw");
end