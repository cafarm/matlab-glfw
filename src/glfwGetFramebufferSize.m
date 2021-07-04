function [width, height] = glfwGetFramebufferSize(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
[~, width, height] = calllibglfw("glfwGetFramebufferSize", window, libpointer("int32Ptr",0), libpointer("int32Ptr",0));
width = double(width);
height = double(height);
end