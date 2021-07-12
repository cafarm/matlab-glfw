function [width, height] = glfwGetWindowSize(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
[~, width, height] = calllibglfw("glfwGetWindowSize", libpointer(window), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
width = double(width);
height = double(height);
end