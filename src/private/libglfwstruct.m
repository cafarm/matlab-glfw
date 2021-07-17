function s = libglfwstruct(varargin)
if ~libisloaded("libglfw")
    loadlibglfw();
end
s = libstruct(varargin{:});
end

