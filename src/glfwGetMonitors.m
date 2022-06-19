function [monitors, count] = glfwGetMonitors()
[~, count] = calllibglfw("glfwGetMonitors", libpointer("int32Ptr",0));
monitors = GLFWmonitor.empty(0,count);
for i = 1:count
    monitor = calllibglfw("glfwGetMonitor", i-1);
    monitors(i) = GLFWmonitor(monitor);
end
count = double(count);
end