function [monitors, count] = glfwGetMonitors()
[monitors, count] = calllibglfw("glfwGetMonitors", libpointer("int32Ptr",0));
count = double(count);
end