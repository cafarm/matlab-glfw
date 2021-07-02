function available = glfwExtensionSupported(extension)
arguments
    extension (1,1) string
end
available = calllibglfw("glfwExtensionSupported", char(extension));
available = double(available);
end
