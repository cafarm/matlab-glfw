function [monitors, count] = glfwGetMonitors()
[monitors, count] = calllibglfw("glfwGetMonitors", 0);
count = double(count);
end