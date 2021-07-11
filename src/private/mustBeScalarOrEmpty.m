function mustBeScalarOrEmpty(value)
if ~isscalar(value) && ~isempty(value)
    error("GLFW:validators:mustBeScalarOrEmpty", "Value must be scalar or empty.");
end
end