function mustBeA(value, type)
arguments
    value
    type (1,1) string
end
if ~isa(value, type)
    error("GLFW:validators:mustBeA", "Value must be %s.", type);
end
end

