function mode = glfwGetVideoMode(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
pmode = calllibglfw("glfwGetVideoMode", monitor);
mode = pmode.Value;
if isNull(pmode)
    mode = mode([]);
end
end
