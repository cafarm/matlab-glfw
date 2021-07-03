function [xpos, ypos] = glfwGetMonitorPos(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
[~, xpos, ypos] = calllibglfw("glfwGetMonitorPos", monitor, libpointer("int32Ptr",0), libpointer("int32Ptr",0));
xpos = double(xpos);
ypos = double(ypos);
end
