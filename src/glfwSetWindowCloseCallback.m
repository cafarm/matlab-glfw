function previousCallback = glfwSetWindowCloseCallback(window, callback)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,1)} = function_handle.empty();
end
persistent callbackMap;
if ~isa(callbackMap, "containers.Map")
    callbackMap = containers.Map("KeyType","int64","ValueType","any");
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", libpointer(window)));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress)tryCallback(callback,window);
end
previousCallbackAddress = glfwRegisterCallback("windowClose", windowAddress, wrappedCallback);
if previousCallbackAddress == 0 || ~callbackMap.isKey(windowAddress)
    previousCallback = function_handle.empty();
else
    previousCallback = callbackMap(windowAddress);
end
callbackMap(windowAddress) = callback;
end
