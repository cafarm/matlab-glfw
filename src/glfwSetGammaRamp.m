function glfwSetGammaRamp(monitor, ramp)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
    ramp (1,1) {mustBeClass(ramp,"GLFWgammaramp"), mustBeValidRamp}
end
calllibglfw("glfwSetGammaRamp", libpointer(monitor), libpointer(ramp));
end

function mustBeValidRamp(r)
if r.size > min([numel(r.red),numel(r.green),numel(r.blue)])
    error("GLFW:validators:mustBeValidRamp", ...
        "Ramp 'size' must be less than or equal to the min number " + ...
        "of elements in 'red', 'blue', or 'green'.");
end
end