function glfwTerminate()
calllibglfw("glfwTerminate");

% Clear callback cache
glfwFolder = fileparts(mfilename("fullpath"));
listing = dir(fullfile(glfwFolder, "*Callback.m"));
n = string({listing.name});
n = replace(n, ".m", "");
n(n=="glfwSetErrorCallback") = [];
clear(n{:});

% Delete library handles
delete(GLFWmonitor.instances());
delete(GLFWwindow.instances());
delete(GLFWcursor.instances());
clear("GLFWmonitor");
clear("GLFWwindow");
clear("GLFWcursor");
end