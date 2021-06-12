function [major, minor, rev] = glfwGetVersion()
loadLibglfw();
[major, minor, rev] = calllib("libglfw", "glfwGetVersion", 0,  0,  0);
end