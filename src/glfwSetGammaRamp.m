function glfwSetGammaRamp(monitor, ramp)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
    ramp (1,1) {mustBeValidRamp}
end
rampPtr = libpointer("GLFWgammarampPtr", struct( ...
    "red", libpointer("uint16Ptr", ramp.red), ...
    "green", libpointer("uint16Ptr", ramp.green), ...
    "blue", libpointer("uint16Ptr", ramp.blue), ...
    "size", numel(ramp.red)));
calllibglfw("glfwSetGammaRamp", libpointer(monitor), rampPtr);
end

function mustBeValidRamp(r)
if ~isa(r, "struct") || ~all(isfield(r, ["red","green","blue"]))
    error("GLFW:validators:mustBeValidRamp", "Ramp must be struct with fields 'red', 'green', 'blue'.");
end
if ~isvector(r.red) || ~isequal(size(r.red),size(r.green),size(r.blue))
    error("GLFW:validators:mustBeValidRamp", "Ramp 'red', 'green', 'blue' fields must be vectors of equal size.");
end
if isfield(r, "size") && ~isequal(r.size,numel(r.red))
    error("GLFW:validators:mustBeValidRamp", "Ramp 'size' field must be equal to number of elements in 'red' ramp.");
end
end