function mustBeLibPointer(value, type)
arguments
    value
    type (1,1) string
end
if ~isa(value, "lib.pointer") || ~strcmp(value.DataType, type)
    error("GLFW:validators:mustBeLibPointer", "Value must be a lib.pointer of type '%s'.", type);
end
end