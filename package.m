function package(version)
arguments
    version (1,1) string = "0.0.0." + datestr(now,"yymm")
end
currentFolder = cd(fileparts(mfilename("fullpath")));
restoreFolder = onCleanup(@()cd(currentFolder));
currentPath = addpath("src");
restorePath = onCleanup(@()path(currentPath));
matlab.addons.toolbox.toolboxVersion("toolbox.prj", version);
matlab.addons.toolbox.packageToolbox("toolbox.prj");
end

