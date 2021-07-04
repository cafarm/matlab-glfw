function mustBeNonnull(value)
arguments
    value
end
if ~isa(value, "lib.pointer") || isNull(value)
    error("GLFW:validators:mustBeNonnull", "Value must be a non-null lib.pointer.");
end
end