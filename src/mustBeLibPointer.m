function mustBeLibPointer(value)
if ~isa(value, "lib.pointer")
    error("Value must be a lib.pointer.")
end
end