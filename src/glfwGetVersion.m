function [major, minor, rev] = glfwGetVersion()
[major, minor, rev] = calllibglfw("glfwGetVersion", 0,  0,  0);
major = double(major);
minor = double(minor);
rev = double(rev);
end