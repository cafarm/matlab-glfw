function varargout = calllibglfw(funcname, varargin)
if ~libisloaded("libglfw")
    loadlibglfw();
end
[varargout{1:nargout}] = calllib("libglfw", funcname, varargin{:});
end