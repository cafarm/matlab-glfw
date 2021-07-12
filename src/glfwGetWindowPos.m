function [xpos, ypos] = glfwGetWindowPos(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
[~, xpos, ypos] = calllibglfw("glfwGetWindowPos", libpointer(window), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
xpos = double(xpos);
ypos = double(ypos);
end
