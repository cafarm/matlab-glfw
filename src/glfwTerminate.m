function glfwTerminate()
calllibglfw("glfwTerminate");

% Clear callback cache
glfwFolder = fileparts(mfilename("fullpath"));
listing = dir(fullfile(glfwFolder, "*Callback.m"));
n = string({listing.name});
n = replace(n, ".m", "");
n(n=="glfwSetErrorCallback") = [];
clear(n{:});
end