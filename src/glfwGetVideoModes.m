function [modes, count] = glfwGetVideoModes(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
[pmodes, ~, count] = calllibglfw("glfwGetVideoModes", monitor, libpointer("int32Ptr",0));
if isNull(pmodes)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getVideoModes:" + id, "Unable to get video modes (%s). %s", id, strjoin(desc, "."));
end
modes = pmodes.Value;
for i = 2:count
    pmodes = pmodes + 1;
    modes(i) = pmodes.Value;
end
count = double(count);
end
