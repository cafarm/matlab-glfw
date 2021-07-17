function previousCallback = glfwSetCharModsCallback(window, callback)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,3)} = function_handle.empty();
end
persistent callbackMap;
if ~isa(callbackMap, "containers.Map")
    callbackMap = containers.Map("KeyType","int64","ValueType","any");
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", libpointer(window)));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,codepoint,mods)tryCallback(callback,window,codepoint,mods);
end
if ~libisloaded("libglfw")
    loadlibglfw();
end
previousCallbackAddress = glfwRegisterCallback("charMods", windowAddress, wrappedCallback);
if previousCallbackAddress == 0 || ~callbackMap.isKey(windowAddress)
    previousCallback = function_handle.empty();
else
    previousCallback = callbackMap(windowAddress);
end
callbackMap(windowAddress) = callback;
end
