function loadLibglfw()
if libisloaded("libglfw")
    return;
end
addPathIfNecessary(libglfwPath);
warnStruct = warning("off", "MATLAB:loadlibrary:TypeNotFound");
restoreWarn = onCleanup(@()warning(warnStruct));
loadlibrary("libglfw", "glfw3.h");
end

function p = libglfwPath()
rootFolder = fileparts(fileparts(mfilename("fullpath")));
glfwFolder = fullfile(rootFolder, "deps", "glfw", lower(computer));
libFolder = fullfile(glfwFolder, "lib");
includeFolder = fullfile(glfwFolder, "include", "GLFW");
p = [libFolder includeFolder];
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