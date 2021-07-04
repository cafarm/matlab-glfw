function [xpos, ypos, width, height] = glfwGetMonitorWorkarea(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
[~, xpos, ypos, width, height] = calllibglfw("glfwGetMonitorWorkarea", monitor, libpointer("int32Ptr",0), libpointer("int32Ptr",0), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
xpos = double(xpos);
ypos = double(ypos);
width = double(width);
height = double(height);
end
