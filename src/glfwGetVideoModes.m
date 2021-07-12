function [modes, count] = glfwGetVideoModes(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
[modesPtr, ~, count] = calllibglfw("glfwGetVideoModes", libpointer(monitor), libpointer("int32Ptr",0));
if isNull(modesPtr)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getVideoModes:" + id, "Unable to get video modes (%s). %s", id, strjoin(desc, "."));
end
modes = modesPtr.Value;
for i = 2:count
    modesPtr = modesPtr + 1;
    modes(i) = modesPtr.Value;
end
count = double(count);
end
