function [xscale, yscale] = glfwGetWindowContentScale(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
[~, xscale, yscale] = calllibglfw("glfwGetWindowContentScale", libpointer(window), libpointer("singlePtr",0), libpointer("singlePtr",0));
xscale = double(xscale);
yscale = double(yscale);
end
