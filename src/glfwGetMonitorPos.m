function [xpos, ypos] = glfwGetMonitorPos(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
[~, xpos, ypos] = calllibglfw("glfwGetMonitorPos", libpointer(monitor), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
xpos = double(xpos);
ypos = double(ypos);
end
