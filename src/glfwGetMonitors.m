function [monitors, count] = glfwGetMonitors()
[monitorsPtr, count] = calllibglfw("glfwGetMonitors", libpointer("int32Ptr",0));
monitors = GLFWmonitor.empty(0,count);
for i = 1:count
    monitors(i) = GLFWmonitor(monitorsPtr);
    monitorsPtr = monitorsPtr + 1;
end
count = double(count);
end