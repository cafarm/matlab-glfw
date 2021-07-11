function glfwSetJoystickCallback(callback)
arguments
    callback function_handle {mustBeCallback(callback,2)} = function_handle.empty();
end
if isempty(callback)
    wrappedCallback = function_handle.empty();
else
    wrappedCallback = @(jid,event)tryCallback(callback,jid,event);
end
glfwRegisterCallback("joystick", wrappedCallback);
end
