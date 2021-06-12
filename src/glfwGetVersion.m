function [major, minor, rev] = glfwGetVersion()
[major, minor, rev] = calllib("libglfw", "glfwGetVersion", 0,  0,  0);
end