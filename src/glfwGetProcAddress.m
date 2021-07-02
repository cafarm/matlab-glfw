function address = glfwGetProcAddress(procname)
arguments
    procname (1,1) string
end
address = calllibglfw("glfwGetProcAddress", char(procname));
end
