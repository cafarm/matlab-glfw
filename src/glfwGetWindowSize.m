function [width, height] = glfwGetWindowSize(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
[~, width, height] = calllibglfw("glfwGetWindowSize", window, libpointer("int32Ptr",0), libpointer("int32Ptr",0));
width = double(width);
height = double(height);
end