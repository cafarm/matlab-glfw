function [monitors, count] = glfwGetMonitors()
[monitors, count] = calllibglfw("glfwGetMonitors", 0);
end