function [xscale, yscale] = glfwGetMonitorContentScale(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
[~, xscale, yscale] = calllibglfw("glfwGetMonitorContentScale", monitor, [], []);
end
