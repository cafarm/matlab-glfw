function glfwSetWindowFocusCallback(window, callback)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", window));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,focused)tryCallback(callback,window,focused);
end
glfwRegisterCallback("windowFocus", windowAddress, wrappedCallback);
end
