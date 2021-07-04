function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
pramp = calllibglfw("glfwGetGammaRamp", monitor);
if isNull(pramp)
    [code,desc] = glfwGetError();
    error("GLFW:getGammaRamp:error", "Unable to get gamma ramp (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
ramp = pramp.Value;
setdatatype(ramp.red, ramp.red.DataType, ramp.size);
setdatatype(ramp.green, ramp.green.DataType, ramp.size);
setdatatype(ramp.blue, ramp.blue.DataType, ramp.size);
ramp.red = double(ramp.red.Value');
ramp.green = double(ramp.green.Value');
ramp.blue = double(ramp.blue.Value');
end
