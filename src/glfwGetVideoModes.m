function [modes, count] = glfwGetVideoModes(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")}
end
[modes, ~, count] = calllibglfw("glfwGetVideoModes", monitor, libpointer("int32Ptr",0));
count = double(count);
end
