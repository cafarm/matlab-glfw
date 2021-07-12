function [widthMM, heightMM] = glfwGetMonitorPhysicalSize(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
[~, widthMM, heightMM] = calllibglfw("glfwGetMonitorPhysicalSize", libpointer(monitor), libpointer("int32Ptr",0), libpointer("int32Ptr",0));
widthMM = double(widthMM);
heightMM = double(heightMM);
end
