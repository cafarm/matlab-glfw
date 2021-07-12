function mustBeNonnull(value)
arguments
    value
end
if isNull(value)
    error("GLFW:validators:mustBeNonnull", "Value must be a non-null.");
end
end