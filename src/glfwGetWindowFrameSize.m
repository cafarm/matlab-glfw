function [left, top, right, bottom] = glfwGetWindowFrameSize(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
[~, left, top, right, bottom] = calllibglfw("glfwGetWindowFrameSize", libpointer(window), libpointer("int32Ptr",0), libpointer("int32Ptr",0), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
left = double(left);
top = double(top);
right = double(right);
bottom = double(bottom);
end
