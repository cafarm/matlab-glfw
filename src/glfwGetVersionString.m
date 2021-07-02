function version = glfwGetVersionString()
version = calllibglfw("glfwGetVersionString");
version = string(version);
end
