function previousCallback = glfwSetWindowIconifyCallback(window, callback)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
persistent callbackMap;
if ~isa(callbackMap, "containers.Map")
    callbackMap = containers.Map("KeyType","int64","ValueType","any");
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", libpointer(window)));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,iconified)tryCallback(callback,window,iconified);
end
previousCallbackAddress = glfwRegisterCallback("windowIconify", windowAddress, wrappedCallback);
if previousCallbackAddress == 0 || ~callbackMap.isKey(windowAddress)
    previousCallback = function_handle.empty();
else
    previousCallback = callbackMap(windowAddress);
end
callbackMap(windowAddress) = callback;
end
