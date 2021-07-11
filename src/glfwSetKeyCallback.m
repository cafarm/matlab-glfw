function glfwSetKeyCallback(window, callback)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,5)} = function_handle.empty();
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", window));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,key,scancode,action,mods)tryCallback(callback,window,key,scancode,action,mods);
end
glfwRegisterCallback("key", windowAddress, wrappedCallback);
end
