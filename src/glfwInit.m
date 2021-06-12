function success = glfwInit()
loadLibglfw();
success = calllib("libglfw", "glfwInit");
end