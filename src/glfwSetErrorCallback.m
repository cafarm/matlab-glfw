function previousCallback = glfwSetErrorCallback(callback)
arguments
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
persistent persistentCallback;
if ~isa(persistentCallback, "function_handle")
    persistentCallback = function_handle.empty();
end
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(code,description)tryCallback(callback,code,description);
end
if ~libisloaded("libglfw")
    loadlibglfw();
end
previousCallbackAddress = glfwRegisterCallback("error", wrappedCallback);
if previousCallbackAddress == 0
    previousCallback = function_handle.empty();
else
    previousCallback = persistentCallback;
end
persistentCallback = callback;
end
