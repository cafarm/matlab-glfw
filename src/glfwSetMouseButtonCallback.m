function glfwSetMouseButtonCallback(window, callback)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,4)} = function_handle.empty();
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", window));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,button,action,mods)tryCallback(callback,window,button,action,mods);
end
glfwRegisterCallback("mouseButton", windowAddress, wrappedCallback);
end
