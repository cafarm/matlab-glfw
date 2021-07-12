function ramp = glfwGetGammaRamp(monitor)
arguments
    monitor (1,1) {mustBeA(monitor,"GLFWmonitor"), mustBeNonnull}
end
rampPtr = calllibglfw("glfwGetGammaRamp", libpointer(monitor));
if isNull(rampPtr)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getGammaRamp:" + id, "Unable to get gamma ramp (%s). %s", id, strjoin(desc, "."));
end
ramp = rampPtr.Value;
setdatatype(ramp.red, ramp.red.DataType, ramp.size);
setdatatype(ramp.green, ramp.green.DataType, ramp.size);
setdatatype(ramp.blue, ramp.blue.DataType, ramp.size);
ramp.red = double(ramp.red.Value');
ramp.green = double(ramp.green.Value');
ramp.blue = double(ramp.blue.Value');
end
