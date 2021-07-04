function mustBeLibPointer(value, type)
arguments
    value
    type string {mustBeScalarOrEmpty} = string.empty()
end
if ~isa(value, "lib.pointer") || (~isempty(type) && ~strcmp(value.DataType, type))
    error("GLFW:validators:mustBeLibPointer", "Value must be a lib.pointer of type '%s'.", type);
end
end