function [widthMM, heightMM] = glfwGetMonitorPhysicalSize(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
[~, widthMM, heightMM] = calllibglfw("glfwGetMonitorPhysicalSize", monitor, libpointer("int32Ptr",0), libpointer("int32Ptr",0));
widthMM = double(widthMM);
heightMM = double(heightMM);
end
