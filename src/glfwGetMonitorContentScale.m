function [xscale, yscale] = glfwGetMonitorContentScale(monitor)
arguments
    monitor (1,1) {mustBeA(monitor,"GLFWmonitor"), mustBeNonnull}
end
[~, xscale, yscale] = calllibglfw("glfwGetMonitorContentScale", libpointer(monitor), libpointer("singlePtr",0), libpointer("singlePtr",0));
xscale = double(xscale);
yscale = double(yscale);
end
