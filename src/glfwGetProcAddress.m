function address = glfwGetProcAddress(procname)
arguments
    procname (1,1) string
end
address = calllibglfw("glfwGetProcAddress", char(procname));
if isNull(address)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getProcAddress:" + id, "Unable to get proc address (%s). %s", id, strjoin(desc, "."));
end
end
