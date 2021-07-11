function tryCallback(callback, varargin)
try
    callback(varargin{:});
catch e
    warning(getReport(e));
end
end