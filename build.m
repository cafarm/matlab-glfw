function build(goal, args)
arguments
    goal (1,1) string = "package"
end
arguments (Repeating)
    args
end

currentFolder = cd(fileparts(mfilename("fullpath")));
restoreFolder = onCleanup(@()cd(currentFolder));

currentPath = addpath("src");
restorePath = onCleanup(@()path(currentPath));

tasks = localfunctions();
names = cellfun(@(f)string(func2str(f)), localfunctions);
if ~ismember(goal, names)
    error("Available tasks:\n%s", join(names, newline));
end
tasks{names==goal}(args{:});
end

function package(prod)
arguments
    prod (1,1) logical = false 
end
compile();
if prod
    v = fileread("VERSION");
else
    [~,rev] = system("git rev-list --count HEAD");
    v = nextver("minor") + "." + deblank(rev);
end
matlab.addons.toolbox.toolboxVersion("toolbox.prj", v);
matlab.addons.toolbox.packageToolbox("toolbox.prj");
end

function test(cov)
arguments
    cov (1,1) logical = false
end
compile();
args = {"tests", "IncludeSubfolders", true};
if cov
    if libisloaded("libglfw")
        unloadlibrary("libglfw");
    end
    args = [args {"ReportCoverageFor", "src"}];
end
results = runtests(args{:});
assertSuccess(results);
end

function cov()
test(true);
end

function ci()
import matlab.unittest.TestRunner;
import matlab.unittest.Verbosity;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.codecoverage.CoberturaFormat;

compile();
suite = testsuite("tests", "IncludeSubfolders", true);

resultsDir = "results/matlab";
[~,~] = mkdir(resultsDir);

runner = TestRunner.withTextOutput("LoggingLevel", Verbosity.Detailed, "OutputDetail", Verbosity.Detailed);
runner.addPlugin(XMLPlugin.producingJUnitFormat(fullfile(resultsDir,"results.xml")));
runner.addPlugin(CodeCoveragePlugin.forFolder("src", "IncludingSubfolders", true, "Producing", CoberturaFormat(fullfile(resultsDir,"coverage.xml"))));

results = runner.run(suite);
assertSuccess(results);
end

function version(type)
arguments
    type string {mustBeMember(type, ["major","minor","patch"])} = string.empty()
end

[~,status] = system("git status -s");
if ~isempty(status)
    error("'git status -s' reports changes. Commit or revert changes before bumping the version.");
end

if isempty(type)
    type = input("type (major|minor|patch): ", "s");
    mustBeMember(type, ["major","minor","patch"]);
end
newver = nextver(type);

fid = fopen("VERSION", "w");
fwrite(fid, newver);
fclose(fid);

system("git commit VERSION -m 'bump version to " + newver + "'");
system("git tag -a v" + newver + " -m 'version " + newver + "'");
end

function v = nextver(type)
arguments
    type string {mustBeMember(type, ["major","minor","patch"])}
end
parts = regexp(fileread("VERSION"), "^([0-9]*).([0-9]*).([0-9]*)$", "tokens");
major = str2double(parts{1}{1});
minor = str2double(parts{1}{2});
patch = str2double(parts{1}{3});
switch type
    case "major"
        v = (major+1) + ".0.0";
    case "minor"
        v = major + "." + (minor+1) + ".0";
    case "patch"
        v = major + "." + minor + "." + (patch+1);
end
if nargout == 0
    disp(v);
end
end

function getdeps(force)
arguments
    force (1,1) logical = false
end
if isfolder("deps") && ~force
    return;
end
system("bash getdeps.sh");
end

function compile(force)
arguments
    force (1,1) logical = false
end
getdeps();
if isfile("src/private/glfwRegisterCallback."+mexext) && ~force
    return;
end
glfwDir = "deps/glfw/"+lower(computer("arch"));
if ispc
    libname = "glfw3dll";
else
    libname = "glfw";
end
mex("-I"+glfwDir+"/include", "-L"+glfwDir+"/lib", "-l"+libname, "-outdir", "src/private", "src/private/glfwRegisterCallback.cpp");
end