function [xscale, yscale] = glfwGetWindowContentScale(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
[~, xscale, yscale] = calllibglfw("glfwGetWindowContentScale", window, libpointer("singlePtr",0), libpointer("singlePtr",0));
xscale = double(xscale);
yscale = double(yscale);
end
