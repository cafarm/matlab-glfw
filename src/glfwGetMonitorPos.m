function [xpos, ypos] = glfwGetMonitorPos(monitor)
arguments
    monitor (1,1) {mustBeLibPointer}
end
[~, xpos, ypos] = calllibglfw("glfwGetMonitorPos", monitor, [], []);
end
