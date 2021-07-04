function [xscale, yscale] = glfwGetMonitorContentScale(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
[~, xscale, yscale] = calllibglfw("glfwGetMonitorContentScale", monitor, libpointer("singlePtr",0), libpointer("singlePtr",0));
xscale = double(xscale);
yscale = double(yscale);
end
