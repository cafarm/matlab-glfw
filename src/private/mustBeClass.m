function mustBeClass(value, type)
arguments
    value
    type (1,1) string
end
if ~isa(value, type)
    error("GLFW:validators:mustBeClass", "Value must be %s.", type);
end
end

