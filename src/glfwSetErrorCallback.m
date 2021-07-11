function glfwSetErrorCallback(callback)
arguments
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(code,description)tryCallback(callback,code,description);
end
glfwRegisterCallback("error", wrappedCallback);
end
