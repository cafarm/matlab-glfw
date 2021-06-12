function success = glfwInit()
if ~libisloaded("libglfw")
    loadlibrary("libglfw", "glfw3");
end
success = calllib("libglfw", "glfwInit");
end