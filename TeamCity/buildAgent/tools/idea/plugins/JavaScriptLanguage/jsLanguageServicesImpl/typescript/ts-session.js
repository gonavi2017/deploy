"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
exports.__esModule = true;
var util_1 = require("./util");
var logger_impl_1 = require("./logger-impl");
function createSessionClass(ts_impl /*must be typeof ts */, logger, commonDefaultOptions, pathProcessor, projectEmittedWithAllFiles, mainFile) {
    var TypeScriptSession = ts_impl.server.Session;
    var TypeScriptCommandNames = ts_impl.server.CommandNames;
    util_1.initCommandNames(TypeScriptCommandNames);
    var host = ts_impl.sys;
    var wasFirstMessage = false;
    var version = ts_impl.version;
    var IDESession = (function (_super) {
        __extends(IDESession, _super);
        function IDESession() {
            return _super !== null && _super.apply(this, arguments) || this;
        }
        IDESession.prototype.beforeFirstMessage = function () {
        };
        IDESession.prototype.refreshStructureEx = function () {
        };
        IDESession.prototype.onMessage = function (message) {
            if (!wasFirstMessage) {
                logger_impl_1.serverLogger("TypeScript service version: " + ts_impl.version, true);
                this.beforeFirstMessage();
                if (commonDefaultOptions) {
                    if (commonDefaultOptions.options) {
                        logger_impl_1.serverLogger("Default service options: " + JSON.stringify(commonDefaultOptions.options), true);
                    }
                    logger_impl_1.serverLogger("Use Single Inferred Project: " + commonDefaultOptions.isUseSingleInferredProject, true);
                }
                else {
                    logger_impl_1.serverLogger("Use Single Inferred Project (no defaults): true", true);
                }
                wasFirstMessage = true;
            }
            _super.prototype.onMessage.call(this, message);
        };
        IDESession.prototype.send = function (msg) {
            var json = JSON.stringify(msg);
            host.write(json + "\n");
        };
        IDESession.prototype.logError = function (err, cmd) {
            var typedErr = err;
            logger_impl_1.serverLogger("Error processing message: " + err.message + " " + typedErr.stack, true);
            _super.prototype.logError.call(this, err, cmd);
        };
        IDESession.prototype.logMessage = function (text, force) {
            if (force === void 0) { force = false; }
            logger_impl_1.serverLogger(text, force);
        };
        IDESession.prototype.getChangeSeq = function () {
            var anyThis = this;
            var superClassSeq = anyThis.changeSeq;
            if (typeof superClassSeq !== "undefined") {
                return superClassSeq;
            }
            logger_impl_1.serverLogger("WARN: Used own sequence implementation (can be slow)", true);
            return this._mySeq;
        };
        IDESession.prototype.updateProjectStructureEx = function () {
            var _this = this;
            var mySeq = this.getChangeSeq();
            var matchSeq = function (n) { return n === mySeq; };
            setTimeout(function () {
                if (matchSeq(_this.getChangeSeq())) {
                    var startTime = Date.now();
                    _this.refreshStructureEx();
                    logger_impl_1.serverLogger("Update project structure scheduler time, mills: " + (Date.now() - startTime), true);
                }
            }, 1500);
        };
        IDESession.prototype.getTime = function () {
            return Date.now();
        };
        IDESession.prototype.compileFileEx = function (req) {
            var _this = this;
            var startCompile = Date.now();
            var compileExactFile = req.file != null;
            if (!compileExactFile && !req.projectFileName) {
                return util_1.doneRequest;
            }
            var requestedFile = ts_impl.normalizePath(req.file ? req.file : req.projectFileName);
            if (!requestedFile) {
                return util_1.doneRequest;
            }
            var _a = this.getProjectForCompileRequest(req, requestedFile), project = _a.project, wasOpened = _a.wasOpened;
            if (logger_impl_1.isLogEnabled) {
                logger_impl_1.serverLogger("Compile get project end time: " + (Date.now() - startCompile));
            }
            var outFiles = [];
            var processedFiles = [];
            var includeErrorsAndProcessedFiles = req.includeErrors;
            var diagnostics = includeErrorsAndProcessedFiles ? [] : undefined;
            var forceUpdate = req.force;
            var needCompile = ((forceUpdate || this.needRecompile(project)));
            if (project && needCompile) {
                var uniqueProjectName = this.getProjectName(project);
                var languageService = this.getLanguageService(project);
                if (compileExactFile && requestedFile && !forceUpdate) {
                    this.ensureFileContentIsActual(requestedFile);
                }
                var program_1 = languageService.getProgram();
                if (logger_impl_1.isLogEnabled) {
                    logger_impl_1.serverLogger("Compile get source files end time: " + program_1.getSourceFiles().length + "(count): time, mills: " + (Date.now() - startCompile));
                    logger_impl_1.serverLogger("Compile project Filename: " + (uniqueProjectName ? uniqueProjectName : "no filename"));
                }
                var options = this.getCompileOptionsEx(project);
                logger_impl_1.serverLogger("Options: " + JSON.stringify(options));
                this.setNewLine(project, options);
                var configFileName = this.getProjectConfigPathEx(project);
                var compileInfoHolder_1 = null;
                if (uniqueProjectName) {
                    compileInfoHolder_1 = projectEmittedWithAllFiles.getOrCreateCompileInfoHolder(uniqueProjectName, configFileName);
                }
                var fileWriteCallback_1 = getFileWrite(configFileName, outFiles, req.contentRootForMacro, req.sourceRootForMacro);
                logger_impl_1.serverLogger("Compile all files using cache checking", true);
                var toUpdateFiles_1 = [];
                var rawSourceFiles = program_1.getSourceFiles();
                rawSourceFiles.forEach(function (val) {
                    if (includeErrorsAndProcessedFiles) {
                        processedFiles.push(val.fileName);
                    }
                    if (!compileInfoHolder_1 || compileInfoHolder_1.checkUpdateAndAddToCache(val, ts_impl)) {
                        toUpdateFiles_1.push(val);
                    }
                });
                var compilerOptions = program_1.getCompilerOptions();
                var useOutFile = compilerOptions && (compilerOptions.outFile || compilerOptions.out);
                if (toUpdateFiles_1.length > 0) {
                    if (toUpdateFiles_1.length == rawSourceFiles.length || useOutFile) {
                        var emitResult = program_1.emit(undefined, fileWriteCallback_1);
                        diagnostics = this.appendEmitDiagnostics(project, emitResult, diagnostics);
                    }
                    else {
                        toUpdateFiles_1.forEach(function (el) {
                            var emitResult = program_1.emit(el, fileWriteCallback_1);
                            diagnostics = _this.appendEmitDiagnostics(project, emitResult, diagnostics);
                        });
                    }
                }
                else {
                    logger_impl_1.serverLogger("No files to update. Source files count: " + rawSourceFiles.length);
                }
                logger_impl_1.serverLogger("Compile end emit files, mills: " + (Date.now() - startCompile));
            }
            else {
                if (project) {
                    logger_impl_1.serverLogger("Compile skip: compileOnSave = false", true);
                }
                else {
                    logger_impl_1.serverLogger("Compile can't find project: shouldn't be happened", true);
                }
            }
            if (includeErrorsAndProcessedFiles) {
                diagnostics = diagnostics.concat(compileExactFile ?
                    this.getDiagnosticsEx([requestedFile], project) :
                    this.getProjectDiagnosticsEx(project));
            }
            this.afterCompileProcess(project, requestedFile, wasOpened);
            if (logger_impl_1.isLogEnabled) {
                logger_impl_1.serverLogger("Compile end get diagnostics time, mills: " + (this.getTime() - startCompile));
            }
            return { response: { generatedFiles: outFiles, infos: diagnostics, processedFiles: processedFiles }, responseRequired: true };
        };
        IDESession.prototype.ensureFileContentIsActual = function (requestedFile) {
            //ensure file content is up-to-date
            try {
                var scriptInfo = this.getScriptInfo(this.projectService, requestedFile);
                if (scriptInfo && !scriptInfo.isOpen) {
                    logger_impl_1.serverLogger("Reload content for compiling " + requestedFile);
                    this.reloadFileFromDisk(scriptInfo);
                    this.refreshStructureEx();
                }
            }
            catch (err) {
                logger_impl_1.serverLogger("ERROR update file content " +
                    requestedFile +
                    " " +
                    err.message +
                    " " +
                    err.stack, true);
                if (logger_impl_1.isLogEnabled) {
                    throw err;
                }
            }
        };
        IDESession.prototype.appendGlobalErrors = function (result, processedProjects, empty) {
            return result;
        };
        IDESession.prototype.updateFilesEx = function (args) {
            var updated = false;
            var files = args.files;
            for (var fileName in files) {
                if (files.hasOwnProperty(fileName)) {
                    var content = files[fileName];
                    if (content !== undefined) {
                        this.changeFileEx(fileName, content);
                        updated = true;
                    }
                }
            }
            if (args.filesToReloadContentFromDisk) {
                for (var _i = 0, _a = args.filesToReloadContentFromDisk; _i < _a.length; _i++) {
                    var fileName = _a[_i];
                    if (!fileName) {
                        continue;
                    }
                    var file = ts_impl.normalizePath(fileName);
                    this.closeClientFileEx(file);
                    if (logger_impl_1.isLogEnabled) {
                        logger_impl_1.serverLogger("Update file from disk (by 'filesToReloadContentFromDisk') " + file);
                    }
                    updated = true;
                }
            }
            if (updated) {
                this.updateProjectStructureEx();
            }
            return util_1.doneRequest;
        };
        IDESession.prototype.getCompletionEx = function (request) {
            var startDate = -1;
            if (logger_impl_1.isLogEnabled) {
                startDate = Date.now();
            }
            var args = request.arguments;
            var result = _super.prototype.executeCommand.call(this, {
                command: TypeScriptCommandNames.Completions,
                arguments: args,
                seq: request.seq,
                type: request.type
            });
            if (logger_impl_1.isLogEnabled) {
                logger_impl_1.serverLogger("Completion service implementation time, mills: " + (this.getTime() - startDate));
            }
            var response = result.response;
            var ideCompletions = this.getDetailedCompletionEx(args, response);
            if (logger_impl_1.isLogEnabled) {
                logger_impl_1.serverLogger("Completion with detailed items time, mills: " + (this.getTime() - startDate));
            }
            return {
                response: ideCompletions,
                responseRequired: true
            };
        };
        IDESession.prototype.executeCommand = function (request) {
            if (request.command == TypeScriptCommandNames.IDEComposite) {
                var responses = {};
                var args = request.arguments;
                if (!args) {
                    return util_1.doneRequest;
                }
                for (var _i = 0, _a = args.nestedRequests; _i < _a.length; _i++) {
                    var el = _a[_i];
                    var response = this.executeCommand(el);
                    responses[el.command] = { body: response.response };
                }
                return { responseRequired: true, response: responses };
            }
            else if (request.command == TypeScriptCommandNames.IDEEmpty) {
                return util_1.doneRequest;
            }
            return _super.prototype.executeCommand.call(this, request);
        };
        IDESession.prototype.getDetailedCompletionEx = function (req, entries) {
            var _this = this;
            if (!entries) {
                return entries;
            }
            var file = ts_impl.normalizePath(req.file);
            var project = this.getProjectForFileEx(file);
            if (!project) {
                logger_impl_1.serverLogger("Can't find project: shouldn't be happened", true);
                return entries;
            }
            var position = this.lineOffsetToPosition(project, file, req.line, req.offset);
            if (position == undefined) {
                return entries;
            }
            var count = 0;
            var time = this.getTime();
            return entries.reduce(function (accumulator, entry) {
                if (count <= util_1.DETAILED_COMPLETION_COUNT && ((_this.getTime() - time) > util_1.DETAILED_MAX_TIME)) {
                    //no time
                    count = util_1.DETAILED_COMPLETION_COUNT + 1;
                }
                if (!util_1.isFunctionKind(entry.kind) || count++ > util_1.DETAILED_COMPLETION_COUNT) {
                    accumulator.push(entry);
                }
                else {
                    var languageService = _this.getLanguageService(project);
                    var details = languageService.getCompletionEntryDetails(file, position, entry.name);
                    if (details) {
                        details.sortText = entry.sortText;
                        accumulator.push(details);
                    }
                }
                return accumulator;
            }, []);
        };
        /**
         * Possible we can remove the implementation if we will use 'pull' events
         * now just for test we use 'blocking' implementation
         * to check speed of processing
         * todo use 'pull' implementation
         */
        IDESession.prototype.getDiagnosticsEx = function (fileNames, commonProject, reqOpen) {
            var _this = this;
            if (reqOpen === void 0) { reqOpen = true; }
            var projectsToProcess = {};
            var hasEmptyProject = false;
            if (commonProject) {
                var configFileName = this.getProjectName(commonProject);
                if (configFileName) {
                    projectsToProcess[configFileName] = commonProject;
                }
                else {
                    hasEmptyProject = true;
                }
            }
            var checkList = fileNames.reduce(function (accumulator, fileName) {
                fileName = ts_impl.normalizePath(fileName);
                if (commonProject) {
                    accumulator.push({ fileName: fileName, project: commonProject });
                }
                else {
                    var project = _this.getProjectForFileEx(fileName);
                    if (project) {
                        accumulator.push({ fileName: fileName, project: project });
                        var projectFilename = _this.getProjectName(project);
                        if (projectFilename) {
                            projectsToProcess[projectFilename] = project;
                        }
                        else {
                            hasEmptyProject = true;
                        }
                    }
                }
                return accumulator;
            }, []);
            var result = [];
            if (checkList.length > 0) {
                var _loop_1 = function (checkSpec) {
                    var file = checkSpec.fileName;
                    var project = checkSpec.project;
                    if (this_1.containsFileEx(project, file, reqOpen)) {
                        var diagnostics = [];
                        var syntacticDiagnostics = this_1.getLanguageService(project).getSyntacticDiagnostics(file);
                        if (syntacticDiagnostics && syntacticDiagnostics.length > 0) {
                            var bakedDiagnostics = syntacticDiagnostics.map(function (el) { return _this.formatDiagnostic(file, checkSpec.project, el); });
                            diagnostics = diagnostics.concat(bakedDiagnostics);
                        }
                        var semanticDiagnostics = this_1.appendPluginDiagnostics(project, this_1.getLanguageService(project).getSemanticDiagnostics(file), file);
                        if (semanticDiagnostics && semanticDiagnostics.length > 0) {
                            var bakedSemanticDiagnostics = semanticDiagnostics.map(function (el) { return _this.formatDiagnostic(file, checkSpec.project, el); });
                            diagnostics = diagnostics.concat(bakedSemanticDiagnostics);
                        }
                        if (commonDefaultOptions === null && project && !this_1.getProjectConfigPathEx(project)) {
                            diagnostics.push({
                                start: null,
                                category: "warning",
                                end: null,
                                text: "Cannot find parent tsconfig.json"
                            });
                        }
                        if (diagnostics && diagnostics.length > 0) {
                            result.push({
                                file: file,
                                diagnostics: diagnostics
                            });
                        }
                    }
                };
                var this_1 = this;
                for (var _i = 0, checkList_1 = checkList; _i < checkList_1.length; _i++) {
                    var checkSpec = checkList_1[_i];
                    _loop_1(checkSpec);
                }
            }
            result = this.appendGlobalErrors(result, projectsToProcess, hasEmptyProject);
            return result;
        };
        IDESession.prototype.getForceProject = function (fileName) {
            return this.getProjectForFileEx(fileName);
        };
        IDESession.prototype.getMainFileDiagnosticsForFileEx = function (fileName) {
            if (mainFile == null) {
                return this.getDiagnosticsEx([fileName]);
            }
            fileName = ts_impl.normalizePath(fileName);
            var project = this.getProjectForFileEx(mainFile);
            if (!project) {
                return [];
            }
            var resultDiagnostics = this.getDiagnosticsEx(project.getFileNames(), project, false);
            if (!this.containsFileEx(project, fileName, false)) {
                if (resultDiagnostics == null) {
                    resultDiagnostics = [];
                }
                resultDiagnostics.push({
                    file: fileName,
                    diagnostics: [{
                            start: null,
                            end: null,
                            text: "File was not processed because there is no a reference from main file"
                        }]
                });
            }
            return resultDiagnostics;
        };
        IDESession.prototype.getProjectDiagnosticsForFileEx = function (fileName) {
            var project = this.getProjectForFileEx(fileName);
            return this.getProjectDiagnosticsEx(project);
        };
        IDESession.prototype.appendPluginProjectDiagnostics = function (project, program, diagnostics) {
            return diagnostics;
        };
        IDESession.prototype.appendPluginDiagnostics = function (project, diagnostics, normalizedFileName) {
            return diagnostics;
        };
        /**
         * copy formatDiagnostic method (but we use 'TS' prefix)
         */
        IDESession.prototype.formatDiagnostic = function (fileName, project, diagnostic) {
            var errorText = (diagnostic.code > 0 ? ("TS" + diagnostic.code + ":") : "") + ts_impl.flattenDiagnosticMessageText(diagnostic.messageText, "\n");
            var startPosition = fileName == null ? null : this.positionToLineOffset(project, fileName, diagnostic.start);
            var endPosition = fileName == null ? null : this.positionToLineOffset(project, fileName, diagnostic.start + diagnostic.length);
            var category = diagnostic.category === ts_impl.DiagnosticCategory.Warning ? "warning" : undefined;
            return {
                start: startPosition,
                end: endPosition,
                text: errorText,
                category: category
            };
        };
        IDESession.prototype.appendEmitDiagnostics = function (project, emitResult, diagnostics) {
            var _this = this;
            if (diagnostics !== undefined && emitResult && emitResult.diagnostics) {
                var emitDiagnostics = emitResult.diagnostics;
                return diagnostics.concat(emitDiagnostics.map(function (el) {
                    var file = el.file;
                    var fileName = file == null ? null : file.fileName;
                    var titleFile = fileName;
                    if (titleFile == null && project) {
                        titleFile = _this.getProjectName(project);
                    }
                    return { file: titleFile, diagnostics: [_this.formatDiagnostic(fileName, project, el)] };
                }));
            }
            return diagnostics;
        };
        IDESession.prototype.getProjectDiagnosticsEx = function (project) {
            if (!project) {
                return [];
            }
            var program = this.getLanguageService(project).getProgram();
            var diagnostics = [];
            var syntax = program.getSyntacticDiagnostics();
            if (syntax && syntax.length > 0) {
                diagnostics = diagnostics.concat(syntax);
            }
            var global = program.getGlobalDiagnostics();
            if (global && global.length > 0) {
                diagnostics = diagnostics.concat(global);
            }
            var semantic = program.getSemanticDiagnostics();
            if (semantic && semantic.length > 0) {
                diagnostics = diagnostics.concat(semantic);
            }
            if (ts_impl.sortAndDeduplicateDiagnostics) {
                diagnostics = ts_impl.sortAndDeduplicateDiagnostics(diagnostics);
            }
            var fileToDiagnostics = {};
            var result = [];
            for (var _i = 0, diagnostics_1 = diagnostics; _i < diagnostics_1.length; _i++) {
                var diagnostic = diagnostics_1[_i];
                var sourceFile = diagnostic.file;
                if (!sourceFile) {
                    result.push({
                        file: this.getProjectConfigPathEx(project),
                        diagnostics: [this.formatDiagnostic(undefined, project, diagnostic)]
                    });
                    continue;
                }
                var fileName = ts_impl.normalizePath(sourceFile.fileName);
                var fileDiagnostics = fileToDiagnostics[fileName];
                if (!fileDiagnostics) {
                    fileDiagnostics = [];
                    fileToDiagnostics[fileName] = fileDiagnostics;
                }
                fileDiagnostics.push(this.formatDiagnostic(fileName, project, diagnostic));
            }
            if (diagnostics && diagnostics.length > 0) {
                for (var fileName in fileToDiagnostics) {
                    if (fileToDiagnostics.hasOwnProperty(fileName)) {
                        var resultDiagnostic = fileToDiagnostics[fileName];
                        if (resultDiagnostic) {
                            result.push({
                                file: fileName,
                                diagnostics: resultDiagnostic
                            });
                        }
                    }
                }
            }
            var projectsToProcess = {};
            var hasEmptyProject = false;
            var projectName = this.getProjectName(project);
            if (projectName) {
                projectsToProcess[projectName] = project;
            }
            else {
                hasEmptyProject = true;
            }
            result = this.appendPluginProjectDiagnostics(project, program, result);
            result = this.appendGlobalErrors(result, projectsToProcess, hasEmptyProject);
            return result;
        };
        return IDESession;
    }(TypeScriptSession));
    return IDESession;
    function getFileWrite(projectFilename, outFiles, contentRoot, sourceRoot) {
        return function (fileName, data, writeByteOrderMark, onError, sourceFiles) {
            var normalizedName = normalizePathIfNeed(ts_impl.normalizePath(fileName), projectFilename);
            normalizedName = fixNameWithProcessor(normalizedName, onError, contentRoot, sourceRoot);
            ensureDirectoriesExist(ts_impl.getDirectoryPath(normalizedName));
            if (logger_impl_1.isLogEnabled) {
                logger_impl_1.serverLogger("Compile write file: " + fileName);
                logger_impl_1.serverLogger("Compile write file (normalized): " + normalizedName);
            }
            host.writeFile(normalizedName, data, writeByteOrderMark, onError, sourceFiles);
            outFiles.push(normalizedName);
        };
    }
    function normalizePathIfNeed(file, projectFilename) {
        if (0 === ts_impl.getRootLength(file)) {
            var contextDir = void 0;
            if (projectFilename) {
                contextDir = ts_impl.getDirectoryPath(projectFilename);
            }
            if (!contextDir) {
                contextDir = host.getCurrentDirectory();
            }
            return ts_impl.getNormalizedAbsolutePath(file, contextDir);
        }
        return file;
    }
    function ensureDirectoriesExist(directoryPath) {
        if (directoryPath.length > ts_impl.getRootLength(directoryPath) && !host.directoryExists(directoryPath)) {
            var parentDirectory = ts_impl.getDirectoryPath(directoryPath);
            ensureDirectoriesExist(parentDirectory);
            host.createDirectory(directoryPath);
        }
    }
    function fixNameWithProcessor(filename, onError, contentRoot, sourceRoot) {
        if (pathProcessor) {
            filename = pathProcessor.getExpandedPath(filename, contentRoot, sourceRoot, onError);
        }
        return filename;
    }
}
exports.createSessionClass = createSessionClass;
