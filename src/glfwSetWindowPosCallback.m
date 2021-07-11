function glfwSetWindowPosCallback(window, callback)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    callback function_handle {mustBeCallback(callback,3)} = function_handle.empty();
end
windowAddress = int64(calllibglfw("glfwGetPointerAddress", window));
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(windowAddress,xpos,ypos)tryCallback(callback,window,xpos,ypos);
end
glfwRegisterCallback("windowPos", windowAddress, wrappedCallback);
end
