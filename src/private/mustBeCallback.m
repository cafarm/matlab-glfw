function mustBeCallback(value, in)
arguments
    value
    in (1,1) double
end
if ~isa(value, "function_handle") || (~isempty(value) && nargin(value) ~= in)
    error("GLFW:validators:mustBeCallback", "Value must be a function handle with %d input arguments or function_handle.empty().", in);
end
end

