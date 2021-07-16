function p = libglfwpointer(varargin)
if ~libisloaded("libglfw")
    loadlibglfw();
end
p = libpointer(varargin{:});
end