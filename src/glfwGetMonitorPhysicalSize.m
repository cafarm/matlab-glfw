function [widthMM, heightMM] = glfwGetMonitorPhysicalSize(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
[~, widthMM, heightMM] = calllibglfw("glfwGetMonitorPhysicalSize", monitor, [], []);
end
