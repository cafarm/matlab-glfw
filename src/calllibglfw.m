function varargout = calllibglfw(funcname, varargin)
if ~libisloaded("libglfw")
    loadlibglfw();
end
[varargout{1:nargout}] = calllib("libglfw", funcname, varargin{:});
end

function loadlibglfw()
addPathIfNecessary(libglfwPath);
warnStruct = warning("off", "MATLAB:loadlibrary:TypeNotFound");
restoreWarn = onCleanup(@()warning(warnStruct));
if ispc
    libName = "glfw3";
else
    libName = "libglfw";
end
[~,~] = loadlibrary(libName, "glfw3.h", "alias", "libglfw");
end

function p = libglfwPath()
rootFolder = fileparts(fileparts(mfilename("fullpath")));
glfwFolder = fullfile(rootFolder, "deps", "glfw", lower(computer("arch")));
if ispc
    libFolder = fullfile(glfwFolder, "bin");
else
    libFolder = fullfile(glfwFolder, "lib");
end
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