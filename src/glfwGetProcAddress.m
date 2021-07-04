function address = glfwGetProcAddress(procname)
arguments
    procname (1,1) string
end
address = calllibglfw("glfwGetProcAddress", char(procname));
if isNull(address)
    [code,desc] = glfwGetError();
    error("GLFW:getProcAddress:error", "Unable to get proc address (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end
