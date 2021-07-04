function [xpos, ypos] = glfwGetWindowPos(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
[~, xpos, ypos] = calllibglfw("glfwGetWindowPos", window, libpointer("int32Ptr",0), libpointer("int32Ptr",0));
xpos = double(xpos);
ypos = double(ypos);
end
