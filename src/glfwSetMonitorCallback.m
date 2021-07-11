function glfwSetMonitorCallback(callback)
arguments
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(monitor,event)tryCallback(callback,monitor,event);
end
glfwRegisterCallback("monitor", wrappedCallback);
end
