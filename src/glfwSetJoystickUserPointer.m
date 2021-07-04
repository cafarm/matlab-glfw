function glfwSetJoystickUserPointer(jid, pointer)
arguments
    jid (1,1) int32
    pointer (1,1) {mustBeLibPointer(pointer,"voidPtr")}
end
calllibglfw("glfwSetJoystickUserPointer", jid, pointer);
end
