function loadLibglfw()
if libisloaded("libglfw")
    return;
end
addPathIfNecessary(libglfwPath);
loadlibrary("libglfw", "glfw3");
end

function p = libglfwPath()
if ismac
    error("macOS not yet supported");
elseif isunix
    p = ["/usr/local/lib","/usr/local/include/GLFW"];
elseif ispc
    error("Windows not yet supported");
else
    error("Platform not supported");
end
end

function addPathIfNecessary(paths)
arguments
    paths (1,:) string
end
mpath = split(string(path()), pathsep);
for p = paths
    if ~ismember(p, mpath)
        addpath(p);
    end
end
end