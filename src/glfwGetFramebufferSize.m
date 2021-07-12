function [width, height] = glfwGetFramebufferSize(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
[~, width, height] = calllibglfw("glfwGetFramebufferSize", libpointer(window), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
width = double(width);
height = double(height);
end