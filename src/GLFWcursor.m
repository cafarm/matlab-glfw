classdef (Sealed) GLFWcursor < handle
    properties (Access = private)
        Pointer (1,1) {mustBeLibPointer(Pointer,"GLFWcursorPtr")} = libpointer("GLFWcursorPtr")
    end
    
    methods
        function cursor = GLFWcursor(pointer)
            arguments
                pointer (1,1) {mustBeLibPointer(pointer,"GLFWcursorPtr")} = libpointer("GLFWcursorPtr")
            end
            cursor.Pointer = pointer;
            GLFWcursor.instances(cursor);
        end

        function tf = isNull(cursor)
            arguments
                cursor (1,1) GLFWcursor
            end
            tf = isNull(cursor.Pointer);
        end
    end

    methods (Hidden)
        function pointer = lib.pointer(cursor)
            pointer = cursor.Pointer;
        end
    end

    methods (Static, Hidden)
        function all = instances(new)
            persistent cursors;
            if ~isa(cursors, "GLFWcursor")
                cursors = GLFWcursor.empty();
            end
            if nargin > 0
                cursors(end+1) = new;
            end
            all = cursors;
        end
    end
end

