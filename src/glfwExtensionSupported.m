function supported = glfwExtensionSupported(extension)
arguments
    extension (1,1) string
end
supported = calllibglfw("glfwExtensionSupported", char(extension));
supported = double(supported);
end
