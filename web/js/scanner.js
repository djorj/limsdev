! function(global, definition) {
    var forceGlobal = window && ("global_scanner" in window) ? window["global_scanner"] : false;
    if (!forceGlobal && typeof module != "undefined" && module.exports) {
        module.exports = definition();
    } else {
        if (!forceGlobal && typeof define == "function" && define.amd) {
            define(definition);
        } else {
            global.scanner = definition();
        }
    }
}(this, function() {
    var s;
    var pageLoadId = (new Date().getTime()) + "-" + Math.floor(Math.random() * (1000 - 0 + 1) + 0);
    var ScannedImage = function(mimeType, srcIsBase64, src, imageInfo, selectedAction, selectedFileName) {
        this.mimeType = mimeType;
        this.srcIsBase64 = srcIsBase64;
        this.src = src;
        this.imageInfo = imageInfo;
        this.selectedAction = selectedAction;
        this.selectedFileName = selectedFileName;
    };
    ScannedImage.prototype.getWidth = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.ImageWidth : undefined;
    };
    ScannedImage.prototype.getHeight = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.ImageLength : undefined;
    };
    ScannedImage.prototype.getBitsPerPixel = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.BitsPerPixel : undefined;
    };
    ScannedImage.prototype.isColor = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.PixelType == 2 : undefined;
    };
    ScannedImage.prototype.isGray = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.PixelType == 1 : undefined;
    };
    ScannedImage.prototype.isBlackWhite = function() {
        return (typeof this.imageInfo === "object") ? this.imageInfo.PixelType == 0 : undefined;
    };
    ScannedImage.prototype.getResolution = function() {
        return (typeof this.imageInfo === "object") ? Math.floor(this.imageInfo.XResolution) : undefined;
    };
    ScannedImage.prototype.getBase64NoPrefix = function() {
        if (!this.srcIsBase64) {
            return undefined;
        }
        return this.srcIsBase64 ? this.base64ToBlob(this.src) : undefined;
    };
    ScannedImage.prototype.toString = function() {
        var s = "";
        if (this.isColor()) {
            s += "Color ";
        } else {
            if (this.isGray()) {
                s += "Gray ";
            } else {
                if (this.isBlackWhite()) {
                    s += "Black/white ";
                }
            }
        }
        s += "image:";
        var width = this.getWidth();
        var height = this.getHeight();
        var bits = this.getBitsPerPixel();
        var resolution = this.getResolution();
        if (width > 0 && height > 0) {
            s += " " + width + " x " + height;
        }
        if (bits > 0) {
            s += " " + bits + "-bit";
        }
        if (resolution > 0) {
            s + " @ " + resolution + " DPI";
        }
        return s;
    };
    var modelsToAppendToBodyFromDeployJava = [];
    var version_regex_base = "^(\\d+)(?:\\.(\\d+)(?:\\.(\\d+)(?:[_\\.](\\d+))?)?)?";
    var version_regex_strict = version_regex_base + "$";
    var version_regex_with_family_modifier = version_regex_base + "(\\*|\\+)?$";
    var scannerDef = {
        version: "2.05",
        MIME_TYPE_BINARY: "application/octet-stream",
        MIME_TYPE_BMP: "image/bmp",
        MIME_TYPE_GIF: "image/png",
        MIME_TYPE_JPEG: "image/jpeg",
        MIME_TYPE_PNG: "image/tiff",
        MIME_TYPE_PDF: "application/pdf",
        scanAppletEnabled: true,
        scanAppletCodeBase: undefined,
        scanAppletCodeBaseFallbackIfNoScannerJs: "https://asprise.azureedge.net/scannerjs/",
        scanAppEnabled: true,
        scanAppDownloadUrl: "plugins/scan-setup.exe",
        scanAppMinVersionRequired: "2.04",
        scanAppLicense: undefined,
        skipLoadDefaultCss: false,
        scanWebSocketServerRangeLowest: 9713,
        scanWebSocketServerRangeHighest: 9716,
        scanWebSocketServerPort: undefined,
        scanWebSocket: undefined,
        scanWebSocketConnectAttemptTime: undefined,
        requestStatus: undefined,
        requestStatusSetOn: undefined,
        REQUEST_STATUS_PENDING: "PENDING",
        REQUEST_STATUS_PROCESSING: "PROCESSING",
        REQUEST_STATUS_COMPLETE: "COMPLETE",
        funcCallsCancelled: [],
        requestFuncCall: undefined,
        requestCallback: undefined,
        formFieldNameForImagesObjects: "com_asprise_scannerjs_images[]",
        formFieldNameForImagesUrls: "com_asprise_scannerjs_images_urls[]",
        isInitialized: false,
        eagerInitialization: window && ("scannerjs_eager_init" in window) ? window["scannerjs_eager_init"] : true,
        fileCount: 0,
        displayInstallScanAppFunc: undefined,
        displayScanReadyPopupFunc: undefined,
        scannerJsEventListener: window && ("scannerjs_event_listener" in window) ? window["scannerjs_event_listener"] : undefined,
        systemResponseCallbackFunc: window && ("scannerjs_sys_response_callback_func" in window) ? window["scannerjs_sys_response_callback_func"] : undefined,
        initialize: function() {
            if (this.isInitialized) {
                return;
            }
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("pre-init");
            }
            this.logToConsole("Initializing Scanner.js ...");
            var skipJava = false;
            var lastScanAppConnTime = this.getLastConnectedTime(true);
            if (lastScanAppConnTime > 0 && (new Date().getTime() - lastScanAppConnTime < 7 * 24 * 3600 * 1000)) {
                if (!(window && ("scannerjs_force_java" in window) ? window["scannerjs_force_java"] : false)) {
                    skipJava = true;
                }
            }
            if ((!skipJava) && this.canUseJavaAppletImpl()) {
                this.appendDeployJavaElementsToBody();
            }
            if (!this.skipLoadDefaultCss) {
                this.loadScannerCssIfNotPresent();
            }
            this.logToConsole(this.bowser.name + " " + this.bowser.version + " supports NPAPI? " + this.doesCurrentBrowserSupportNPAPI());
            try {
                if ((!skipJava) && this.canUseJavaAppletImpl() && this.doesCurrentBrowserSupportNPAPI()) {
                    this.addScanAppletToDomIfNotExists(null, 1, 1);
                }
            } catch (je) {
                this.logToConsole("Failed to add applet element: " + je, true);
            }
            if (this.canUseWebSocketImpl()) {
                if (skipJava || !this.hasJava() || this.bowser.firefox) {
                    window.setTimeout(function() {
                        scanner.connectToScanWebSocketServer();
                    }, 200);
                } else {
                    this.logToConsole("Java: " + this.deployJava.getJREs());
                }
            }
            window.setInterval(function() {
                scanner.monitorFuncCallRequest();
            }, 4000);
            this.logToConsole("Scanner.js initialized.");
            this.isInitialized = true;
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("post-init");
            }
        },
        monitorFuncCallRequest: function() {
            if ((typeof this.requestStatus === "undefined") || (typeof this.requestStatusSetOn === "undefined")) {
                return;
            }
            if (this.requestStatus == this.REQUEST_STATUS_PENDING && (new Date().getTime() - this.requestStatusSetOn > 10 * 1000)) {
                this.displayInstallScanAppEnableJavaPopup(true);
            }
        },
        callFunction: function(callbackFunc, funcName, arg1, arg2, argsMore) {
            if (arguments.length < 2) {
                this.reportError("Invalid function call - func name is not specified");
                return false;
            }
            if (typeof callbackFunc !== "function") {
                this.reportError("asprise_scanner_js_call_function requires a valid callbackFunc");
                return false;
            }
            if (this.requestStatus == this.REQUEST_STATUS_PENDING || this.requestStatus == this.REQUEST_STATUS_PROCESSING) {
                this.reportError("You can not submit a new request as the previous request has not completed yet.");
                return false;
            }
            if (!JSON || typeof JSON.stringify !== "function") {
                this.reportError("JSON.stringify is not supported by your browser.");
                return false;
            }
            var funcCallObject = {
                "funcCallId": "" + new Date().getTime() + "-" + Math.floor(Math.random() * 10000),
                "funcName": funcName,
                "time": new Date().getTime(),
                "userAgent": navigator.userAgent,
                "isModernBrowser": this.isModernBrowser(),
                "windowTitle": document.title,
                "url": window.location.href,
                "pageLoadId": this.getPageSessionId()
            };
            var funcArgs = [];
            for (var a = 2; a < arguments.length; a++) {
                funcArgs.push(arguments[a]);
            }
            funcCallObject["funcArgs"] = funcArgs;
            var funcCallJsonString = JSON.stringify(funcCallObject);
            this.requestStatus = this.REQUEST_STATUS_PENDING;
            this.requestStatusSetOn = new Date().getTime();
            this.requestFuncCall = funcCallJsonString;
            this.requestCallback = callbackFunc;
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("func-call", funcCallJsonString);
            }
            this.funcCallToWebSocket();
            return true;
        },
        cancelFuncCalls: function() {
            if (this.requestStatus == this.REQUEST_STATUS_PENDING || this.requestStatus == this.REQUEST_STATUS_PROCESSING) {
                var funcCallObj = JSON.parse(this.requestFuncCall);
                this.funcCallsCancelled.push(funcCallObj);
                this.logToConsole("Canceled func call: " + funcCallObj["funcName"] + ", call id: " + funcCallObj["funcCallId"]);
                if (this.scannerJsEventListener) {
                    this.scannerJsEventListener("func-canceled", funcCallObj);
                }
            }
            this.requestStatus = undefined;
        },
        funcCallToWebSocket: function() {
            if (!this.isConnectedToScanWebSocket()) {
                return false;
            }
            if (this.requestStatus != this.REQUEST_STATUS_PENDING) {
                return true;
            }
            try {
                this.scanWebSocket.send(this.requestFuncCall);
                this.requestStatus = this.REQUEST_STATUS_PROCESSING;
                this.requestStatusSetOn = new Date().getTime();
                return true;
            } catch (e) {
                this.functionReturn(false, "Failed: " + e, null, null, null, null, null);
                this.logToConsole(e, true);
                return false;
            }
        },
        funcCallResponseFromWebSocket: function(successful, response) {
            if (successful) {
                var returned = null;
                if ((typeof response === "string") && response.length > 6 && response.substr(0, 6) == "<error") {
                    throw response;
                }
                var systemResponsePrefix = "SYSTEM/";
                if (response && response.length > systemResponsePrefix.length && response.substr(0, systemResponsePrefix.length) == systemResponsePrefix) {
                    try {
                        if (this.systemResponseCallbackFunc) {
                            var colonPos = response.indexOf(":");
                            if (colonPos > 0) {
                                this.systemResponseCallbackFunc(response.substr(0, colonPos), response.substr(colonPos + 1));
                            } else {
                                this.reportError("Invalid system response: " + response);
                            }
                        } else {}
                    } catch (se) {}
                    return;
                }
                try {
                    returned = JSON.parse(response);
                } catch (e) {
                    this.reportError("Failed to parse JSON: " + response);
                    this.functionReturn(false, "Failed to parse JSON: " + response, null, null, null, null, null);
                    return;
                }
                if (returned instanceof Array) {
                    this.functionReturn(returned[0], returned[1], returned[2], returned[3], returned[4], returned.length > 5 ? returned[5] : null, returned.length > 6 ? returned[6] : null);
                } else {
                    this.functionReturn(false, "JSON returned from WebSocket is not array", null, null, null, null, null);
                }
            } else {
                this.functionReturn(false, "Failed due to WebSocket error", null, null, null, null, null);
            }
        },
        functionReturn: function(successful, mesg, log, callbackFuncName, resultCount, result, funcCallId) {
            if (!(resultCount == null || resultCount == 1)) {
                this.reportError("resultCount should be null or 1, actual: " + resultCount);
            }
            if (funcCallId) {
                for (var i = 0; i < this.funcCallsCancelled.length; i++) {
                    var funcCallCancelled = this.funcCallsCancelled[i];
                    if (funcCallCancelled != null && funcCallCancelled["funcCallId"] == funcCallId) {
                        this.logToConsole("Response is ignored for cancelled func call: " + funcCallCancelled["funcName"] + ", call id: " + funcCallCancelled["funcCallId"] + ":\n" + result);
                        return;
                    }
                }
            }
            this.requestStatus = this.REQUEST_STATUS_COMPLETE;
            this.requestStatusSetOn = new Date().getTime();
            this.requestCallback(successful, mesg, result);
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("func-return");
            }
        },
        onAppletStarted: function(info) {
            this.logToConsole("Applet started: " + info);
            this._onReady(false);
        },
        scan: function(callbackFunc, requestSpecObject, useAspriseDialog, showScannerUI) {
            if ((typeof requestSpecObject !== "string") && (!JSON || typeof JSON.stringify !== "function")) {
                this.reportError("JSON.stringify is not supported by your browser.");
                return false;
            }
            var requestSpecInString = (typeof requestSpecObject === "string") ? requestSpecObject : JSON.stringify(requestSpecObject);
            return this.callFunction(callbackFunc, "scan", requestSpecInString, arguments.length >= 3 ? useAspriseDialog : null, arguments.length >= 4 ? showScannerUI : null);
        },
        listSources: function(callbackFunc, nameOnly, capsToRetrieve, detectDeviceType, excludeTwainDsOnWia, requestSpec) {
            return this.callFunction(callbackFunc, "listSources", arguments.length >= 2 ? nameOnly : true, arguments.length >= 3 ? capsToRetrieve : null, arguments.length >= 4 ? detectDeviceType : false, arguments.length >= 5 ? excludeTwainDsOnWia : true, arguments.length >= 6 && requestSpec != null ? ((typeof requestSpec === "string") ? requestSpec : JSON.stringify(requestSpec)) : "");
        },
        getSource: function(callbackFunc, sourceName, nameOnly, capsToRetrieve, getCurrent, detectDeviceType, capsToSet, requestSpec) {
            return this.callFunction(callbackFunc, "getSource", arguments.length >= 2 ? sourceName : "select", arguments.length >= 3 ? nameOnly : true, arguments.length >= 4 ? capsToRetrieve : null, arguments.length >= 5 ? getCurrent : true, arguments.length >= 6 ? detectDeviceType : false, arguments.length >= 7 ? capsToSet : null, arguments.length >= 8 && requestSpec != null ? ((typeof requestSpec === "string") ? requestSpec : JSON.stringify(requestSpec)) : "");
        },
        getSystemInfo: function(callbackFunc) {
            return this.callFunction(callbackFunc, "asprise_scan_system_info");
        },
        submitFormWithImages: function(formId, images, onReadyStateChangeHandler) {
            if ((!(images instanceof Array)) || images.length == 0) {
                this.reportError("no images - form submit cancelled.");
                return undefined;
            }
            for (var i = 0; i < images.length; i++) {
                var image = images[i];
                if (!(image instanceof ScannedImage)) {
                    this.logToConsole("Invalid image object: " + image, true);
                    this.reportError("Invalid image object!");
                    return undefined;
                }
            }
            var formElement = document.getElementById(formId);
            if (formElement == null) {
                this.reportError("Form doesn't exist: " + formId);
                return undefined;
            }
            var fd = new FormData(formElement);
            for (var i = 0; i < images.length; i++) {
                var image = images[i];
                if (image.srcIsBase64) {
                    fd.append(this.formFieldNameForImagesObjects, this.base64ToBlob(image.src, image.mimeType));
                } else {
                    fd.append(this.formFieldNameForImagesUrls, image.src);
                }
            }
            this.logToConsole("POST images, count: " + images.length);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", formElement.getAttribute("action"), true);
            xhr.onreadystatechange = function() {
                if (typeof(onReadyStateChangeHandler) == "function") {
                    onReadyStateChangeHandler(xhr);
                }
            };
            xhr.send(fd);
            this.logToConsole("Form posted: " + xhr);
            return xhr;
        },
        getScannedImages: function(response, includeOriginals, includeThumbnails) {
            var images = [];
            if (arguments.length < 2) {
                includeOriginals = true;
            }
            if (arguments.length < 3) {
                includeThumbnails = false;
            }
            if (!includeOriginals && !includeThumbnails) {
                this.reportError("getImages: will return no image as neither includeOriginals nor includeThumbnails is true.");
                return images;
            }
            if (typeof response === "string") {
                if (response.length > 6 && response.substr(0, 6) == "<error") {
                    throw response;
                }
                try {
                    response = JSON.parse(response);
                } catch (jsonE) {
                    throw response;
                }
            }
            if (typeof response === "object" && response.output instanceof Array) {
                var outputs = response.output;
                for (var o = 0; o < outputs.length; o++) {
                    var output = outputs[o];
                    if ((includeOriginals && output.type == "return-base64") || (includeThumbnails && output.type == "return-base64-thumbnail")) {
                        var mimeType = this.getMimeType(output.format);
                        if (mimeType == this.MIME_TYPE_BINARY) {
                            this.logToConsole("Unable to find mime type for " + output.format);
                            continue;
                        }
                        if (!(output.result instanceof Array)) {
                            this.logToConsole("Output contains no result records", true);
                            continue;
                        }
                        for (var r = 0; r < output.result.length; r++) {
                            var imgInfo = (response.images instanceof Array) && r < response.images.length ? response.images[r].image_info : undefined;
                            images.push(new ScannedImage(mimeType, true, "data:" + mimeType + ";base64," + output.result[r], imgInfo, output.hasOwnProperty("selected_action") ? output.selected_action : undefined, output.hasOwnProperty("selected_filename") ? output.selected_filename : undefined));
                        }
                    } else {}
                }
            }
            return images;
        },
        getUploadResponse: function(response) {
            if (typeof response === "string") {
                if (response.length > 6 && response.substr(0, 6) == "<error") {
                    throw response;
                }
                try {
                    response = JSON.parse(response);
                } catch (jsonE) {
                    throw response;
                }
            }
            if (typeof response === "object" && response.output instanceof Array) {
                var outputs = response.output;
                for (var o = 0; o < outputs.length; o++) {
                    var output = outputs[o];
                    if (output.type == "upload" || output.type == "upload-thumbnail") {
                        if ((output.result instanceof Array) && output.result.length > 0) {
                            return output.result[0];
                        }
                    }
                }
            }
            return undefined;
        },
        getSaveResponse: function(response) {
            if (typeof response === "string") {
                if (response.length > 6 && response.substr(0, 6) == "<error") {
                    throw response;
                }
                try {
                    response = JSON.parse(response);
                } catch (jsonE) {
                    throw response;
                }
            }
            if (typeof response === "object" && response.output instanceof Array) {
                var outputs = response.output;
                for (var o = 0; o < outputs.length; o++) {
                    var output = outputs[o];
                    if (output.type == "save" || output.type == "save-thumbnail") {
                        return JSON.stringify(output.result);
                    }
                }
            }
            return undefined;
        },
        onScanWebSocketMesg: function(ws, mesg) {
            scanner.funcCallResponseFromWebSocket(true, mesg.data);
        },
        isConnectedToScanWebSocket: function() {
            return this.scanWebSocket != undefined;
        },
        _onReady: function(scanApp) {
            try {
                var key = "sjs_" + (scanApp ? "app" : "applet");
                var connectedOn = new Date();
                this.writeToLocalStorage(key + "_last_connected", connectedOn.getTime().toString(10));
                this.setCookie(key + "_last_connected", connectedOn.getTime().toString(10));
            } catch (e) {}
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("ready", scanApp);
            }
        },
        getLastConnectedTime: function(scanApp) {
            try {
                var key = "sjs_" + (scanApp ? "app" : "applet");
                var value = this.readFromLocalStorage(key + "_last_connected");
                if (!value) {
                    value = this.getCookie(key + "_last_connected");
                }
                if (value) {
                    return parseInt(value, 10);
                }
            } catch (e) {}
            return -1;
        },
        onScanWebSocketOpen: function(ws, open) {
            scanner.scanWebSocket = ws;
            scanner.logToConsole("Scan WebSocket server connected: " + scanner.scanWebSocket.url);
            scanner.cancelFuncCalls();
            scanner.displayInstallScanAppEnableJavaPopup(false);
            scanner.displayScanReadyPopup();
            scanner._onReady(true);
            var license = scanner.scanAppLicense;
            if (!license) {
                license = window.com_asprise_scan_app_license;
            }
            if (license) {
                ws.send("LICENSE: " + license);
            }
            if (scanner.scanAppMinVersionRequired) {
                ws.send("MIN_VERSION: " + scanner.scanAppMinVersionRequired);
            }
            scanner.funcCallToWebSocket();
        },
        onScanWebSocketClose: function(ws, close) {
            scanner.scanWebSocket = undefined;
            scanner.connectToScanWebSocketServer(true);
        },
        failedToConnectToWebSocketServer: function() {
            this.logToConsole("Failed to connect to WebSocket server.", true);
            if (this.scannerJsEventListener) {
                this.scannerJsEventListener("fail-to-connect");
            }
            if (!this.doesCurrentBrowserSupportNPAPI()) {
                this.displayInstallScanAppEnableJavaPopup(true);
            }
            if ((!(this.maxConnectionAttempts > 0)) || this.connectionAttempts < this.maxConnectionAttempts) {
                this.connectToScanWebSocketServer();
            } else {
                this.connectionAttempts = 0;
                this.isAttemptingToConnect = false;
                if (this.scannerJsEventListener) {
                    this.scannerJsEventListener("fail-to-connect-final");
                }
            }
        },
        getScanWsHost: function() {
            if (window.location.href != null && window.location.href.substr(0, 5) == "http:") {
                return "ws://127.0.0.1";
            }
            return "wss://local.scannerjs.com";
        },
        connectionAttempts: 0,
        maxConnectionAttempts: -1,
        isAttemptingToConnect: false,
        connectToScanWebSocketServer: function(inTheSameAttempt) {
            if (!this.canUseWebSocketImpl()) {
                this.reportError("Cancelled as scan app implementation is disabled explicitly.");
                return;
            }
            if (this.scanWebSocket) {
                this.scanWebSocketConnectAttemptTime = undefined;
                this.scanWebSocket.close();
                return;
            }
            if (!inTheSameAttempt) {
                this.scanWebSocketServerPort = undefined;
                this.connectionAttempts += 1;
            }
            this.isAttemptingToConnect = true;
            var host = this.getScanWsHost();
            var isWss = host.length > 3 && host.substr(0, 3).toLowerCase() == "wss";
            if (this.scanWebSocketServerPort == undefined) {
                this.scanWebSocketServerPort = this.scanWebSocketServerRangeLowest;
            } else {
                if (this.scanWebSocketConnectAttemptTime != undefined && ((new Date().getTime()) - this.scanWebSocketConnectAttemptTime < 10 * 1000)) {
                    this.scanWebSocketServerPort += 1;
                } else {}
            }
            if (this.scanWebSocketServerPort % 2 != (isWss ? 0 : 1)) {
                this.scanWebSocketServerPort += 1;
            }
            if (this.scanWebSocketServerPort < this.scanWebSocketServerRangeLowest || this.scanWebSocketServerPort > this.scanWebSocketServerRangeHighest) {
                this.failedToConnectToWebSocketServer();
                return;
            }
            this.scanWebSocketConnectAttemptTime = (new Date().getTime());
            this.createWebSocket(host + ":" + this.scanWebSocketServerPort + "/" + this.getPageSessionId() + "/" + encodeURIComponent(this.removeFragmentFromUrl(window.location.href)), this.onScanWebSocketOpen, this.onScanWebSocketClose, this.onScanWebSocketMesg, undefined);
        },
        canUseWebSocketImpl: function() {
            return this.scanAppEnabled;
        },
        canUseJavaAppletImpl: function() {
            return this.scanAppletEnabled;
        },
        getScannerJsBaseUrl: function() {
            var sc = document.getElementsByTagName("script");
            for (var idx = 0; idx < sc.length; idx++) {
                var s = sc.item(idx);
                if (s.src && s.src.match(/scanner\.js(\?\w*)?$/)) {
                    var url = s.src;
                    var base = url.substring(0, url.lastIndexOf("/") + 1);
                    return base;
                }
            }
            return "https://asprise.azureedge.net/scannerjs/";
        },
        addScanAppletToDomIfNotExists: function(parentElement, width, height) {
            var _com_asprise_scan_applet_info_id = "com_asprise_scan_applet";
            var _com_asprise_scan_applet_info_codebase = this.scanAppletCodeBase;
            if (!_com_asprise_scan_applet_info_codebase) {
                _com_asprise_scan_applet_info_codebase = this.getScannerJsBaseUrl();
            }
            if (!_com_asprise_scan_applet_info_codebase) {
                _com_asprise_scan_applet_info_codebase = this.scanAppletCodeBaseFallbackIfNoScannerJs;
            }
            if (_com_asprise_scan_applet_info_codebase.indexOf("FORCE_REFRESH") > -1 && window.location.href.indexOf("FORCE_REFRESH") > -1) {
                _com_asprise_scan_applet_info_codebase = _com_asprise_scan_applet_info_codebase.replace(/FORCE_REFRESH/g, "FORCE_REFRESH_" + (new Date()).getTime());
            }
            var _com_asprise_scan_applet_info_classname = "com.asprise.imaging.scan.ui.web.ScanApplet";
            var _com_asprise_scan_applet_info_jarname = "asprise_scan.jar";
            var _com_asprise_scan_applet_info_jarname_legacy = "asprise_scan-legacy.jar";
            var elementApplet = document.getElementById(_com_asprise_scan_applet_info_id);
            if (elementApplet != null) {
                return true;
            }
            elementApplet = this.createAppletDomElement(_com_asprise_scan_applet_info_id, _com_asprise_scan_applet_info_codebase, this.is7u45OrAbove() ? _com_asprise_scan_applet_info_jarname : _com_asprise_scan_applet_info_jarname_legacy, _com_asprise_scan_applet_info_classname, width, height);
            if (parentElement == null) {
                var elementBodyList = document.getElementsByTagName("body");
                var elementBody = (elementBodyList != null && elementBodyList.length > 0) ? elementBodyList.item(0) : null;
                if (elementBody == null) {
                    this.reportError('please do not execute com_asprise_scan_addScanAppletToDomIfNotExists in <header>. document.getElementsByTagName("body").length = ' + document.getElementsByTagName("body").length);
                    return false;
                }
                elementBody.appendChild(elementApplet);
            } else {
                parentElement.appendChild(elementApplet);
            }
            return true;
        },
        displayInstallScanAppEnableJavaPopup: function(display) {
            if (typeof this.displayInstallScanAppFunc == "function") {
                return this.displayInstallScanAppFunc(display);
            }
            var _com_asprise_scan_prompt_id = "com_asprise_scan_prompt";
            var _com_asprise_scan_prompt_overlay_id = "com_asprise_scan_prompt_overlay";
            if ((!display) && document.getElementById(_com_asprise_scan_prompt_id) == null) {
                return true;
            }
            this.addInstallPromptDomElementIfNotExists();
            var elementPrompt = document.getElementById(_com_asprise_scan_prompt_id);
            if (elementPrompt == null) {
                this.reportError("Unable to find prompt of id: " + _com_asprise_scan_prompt_id);
                return false;
            }
            var browserMaySupportJava = this.doesCurrentBrowserSupportNPAPI();
            var elementsJava = elementPrompt.querySelectorAll(".java");
            for (var index = 0; index < elementsJava.length; index++) {
                elementsJava[index].style.display = browserMaySupportJava ? "block" : "none";
            }
            var elementsNoJava = elementPrompt.querySelectorAll(".nojava");
            for (var index = 0; index < elementsNoJava.length; index++) {
                elementsNoJava[index].style.display = browserMaySupportJava ? "none" : "block";
            }
            elementPrompt.style.display = display ? "block" : "none";
            var elementOverlay = document.getElementById(_com_asprise_scan_prompt_overlay_id);
            if (elementOverlay == null) {
                this.logToConsole("Prompt overlay doesn't exist (id: " + _com_asprise_scan_prompt_overlay_id + ").");
            } else {
                elementOverlay.style.display = display ? "block" : "none";
            }
            return true;
        },
        displayScanReadyPopup: function() {
            if (typeof this.displayScanReadyPopupFunc == "function") {
                return this.displayScanReadyPopupFunc();
            }
            var _com_asprise_scan_app_ok_id = "com_asprise_scan_app_ok";
            this.addScanReadyPromptDomElementIfNotExists();
            var elementPrompt = document.getElementById(_com_asprise_scan_app_ok_id);
            if (elementPrompt == null) {
                return false;
            }
            elementPrompt.style.display = "block";
            window.setTimeout(function() {
                scanner.setElementStyleDisplay(document.getElementById("com_asprise_scan_app_ok"), "none");
            }, 4 * 1000);
            return true;
        },
        addInstallPromptDomElementIfNotExists: function() {
            var urlAppDownload = this.scanAppDownloadUrl;
            var _com_asprise_scan_prompt_id = "com_asprise_scan_prompt";
            var elementPrompt = document.getElementById(_com_asprise_scan_prompt_id);
            if (elementPrompt != null) {
                return true;
            }
            var divPromptModel = {
                "name": "div",
                "attributes": {
                    "id": "com_asprise_scan_prompt",
                    "class": "com_asprise_scan_prompt_class prompt-dialog",
                    "style": "display: none;"
                },
                "children": [{
                    "name": "a",
                    "attributes": {
                        "class": "top-right-closer",
                        "title": "Dismiss this dialog",
                        "onclick": "scanner.displayInstallScanAppEnableJavaPopup(false);"
                    }
                }, {
                    "name": "h3",
                    "attributes": {
                        "style": "margin-top: 0px;",
                        "text": "Please Enable Scanning"
                    }
                }, {
                    "name": "div",
                    "attributes": {
                        "class": "java",
                        "style": "display: none;"
                    },
                    "children": [{
                        "name": "p",
                        "attributes": {
                            "text": "In order to scan directly from your browser, you need to either enable Java or install the scan app: "
                        }
                    }, {
                        "name": "table",
                        "attributes": {
                            "width": "100%"
                        },
                        "children": [{
                            "name": "td",
                            "attributes": {
                                "width": "50%",
                                "align": "center",
                                "valign": "top"
                            },
                            "children": [{
                                "name": "h4",
                                "attributes": {
                                    "text": "Either Option 1:"
                                }
                            }, {
                                "name": "a",
                                "attributes": {
                                    "class": "icon-action icon-action-enable-java",
                                    "href": "javascript:scanner.displayEnableJavaHelp();"
                                }
                            }, {
                                "name": "p",
                                "attributes": {
                                    "style": "vertical-align: middle; text-align: center;"
                                },
                                "children": [{
                                    "name": "a",
                                    "attributes": {
                                        "href": "javascript:scanner.displayEnableJavaHelp();",
                                        "text": "Enable Java"
                                    }
                                }, {
                                    "name": "span",
                                    "attributes": {
                                        "text": "; once done, please "
                                    }
                                }, {
                                    "name": "button",
                                    "attributes": {
                                        "type": "button",
                                        "class": "btn btn-default btn-xs",
                                        "onclick": "document.location.reload(false);",
                                        "style": "",
                                        "text": "Refresh Page"
                                    }
                                }]
                            }, ]
                        }, {
                            "name": "td",
                            "attributes": {
                                "width": "10px"
                            }
                        }, {
                            "name": "td",
                            "attributes": {
                                "width": "1px",
                                "style": "background-color: #cccccc;"
                            }
                        }, {
                            "name": "td",
                            "attributes": {
                                "width": "10px"
                            }
                        }, {
                            "name": "td",
                            "attributes": {
                                "align": "center",
                                "valign": "top"
                            },
                            "children": [{
                                "name": "h4",
                                "attributes": {
                                    "text": "Or Option 2:"
                                }
                            }, {
                                "name": "a",
                                "attributes": {
                                    "class": "icon-action icon-action-install-app",
                                    "href": urlAppDownload,
                                    "target": "_blank"
                                }
                            }, {
                                "name": "p",
                                "children": [{
                                    "name": "a",
                                    "attributes": {
                                        "href": urlAppDownload,
                                        "target": "_blank",
                                        "text": "Download and run it"
                                    }
                                }, {
                                    "name": "span",
                                    "attributes": {
                                        "text": ". No need to refresh page."
                                    }
                                }]
                            }]
                        }]
                    }]
                }, {
                    "name": "div",
                    "attributes": {
                        "class": "nojava",
                        "style": "display: none;"
                    },
                    "children": [{
                        "name": "p",
                        "attributes": {
                            "text": "In order to scan directly from your browser, you need to install the scan app: "
                        }
                    }, {
                        "name": "a",
                        "attributes": {
                            "class": "icon-action icon-action-install-app",
                            "href": urlAppDownload,
                            "target": "_blank"
                        }
                    }, {
                        "name": "p",
                        "attributes": {
                            "style": "vertical-align: middle; text-align: center;"
                        },
                        "children": [{
                            "name": "a",
                            "attributes": {
                                "href": urlAppDownload,
                                "target": "_blank",
                                "text": "Download and run it"
                            }
                        }, {
                            "name": "span",
                            "attributes": {
                                "text": ". No need to refresh page."
                            }
                        }]
                    }]
                }]
            };
            var divOverlayModel = {
                "name": "div",
                "attributes": {
                    "id": "com_asprise_scan_prompt_overlay",
                    "class": "com_asprise_scan_prompt_overlay_class overlay-for-prompt",
                    "style": "display: none;"
                },
            };
            var elementBodyList = document.getElementsByTagName("body");
            var elementBody = (elementBodyList != null && elementBodyList.length > 0) ? elementBodyList.item(0) : null;
            if (elementBody == null) {
                this.reportError("please do not execute com_asprise_scan_addInstallPromptDomElementIfNotExists in <header>!");
                return false;
            }
            elementBody.appendChild(this.createDomElementFromModel(divPromptModel));
            elementBody.appendChild(this.createDomElementFromModel(divOverlayModel));
            return true;
        },
        addScanReadyPromptDomElementIfNotExists: function() {
            var _com_asprise_scan_app_ok_id = "com_asprise_scan_app_ok";
            var elementPrompt = document.getElementById(_com_asprise_scan_app_ok_id);
            if (elementPrompt != null) {
                return true;
            }
            var divPromptModel = {
                "name": "div",
                "attributes": {
                    "id": "com_asprise_scan_app_ok",
                    "class": "com_asprise_scan_app_ok_class prompt-dialog",
                    "style": "display: none;"
                },
                "children": [{
                    "name": "a",
                    "attributes": {
                        "class": "top-right-closer",
                        "title": "Dismiss this dialog",
                        "onclick": "scanner.setElementStyleDisplay(document.getElementById('com_asprise_scan_app_ok'), 'none');"
                    }
                }, {
                    "name": "h3",
                    "attributes": {
                        "style": "text-align: center;"
                    },
                    "children": [{
                        "name": "span",
                        "attributes": {
                            "style": "font-size: larger; color: #00A000;",
                            "text": "✔"
                        }
                    }, {
                        "name": "span",
                        "attributes": {
                            "text": " SCANNING ENABLED"
                        }
                    }]
                }, {
                    "name": "p",
                    "attributes": {
                        "style": "vertical-align: middle; text-align: center;",
                        "text": "You may now scan directly from your browsers."
                    }
                }]
            };
            var elementBodyList = document.getElementsByTagName("body");
            var elementBody = (elementBodyList != null && elementBodyList.length > 0) ? elementBodyList.item(0) : null;
            if (elementBody == null) {
                this.reportError("please do not execute addScanReadyPromptDomElementIfNotExists in <header>!");
                return false;
            }
            //elementBody.appendChild(this.createDomElementFromModel(divPromptModel));
            return true;
        },
        insertCss: function(code) {
            var style = document.createElement("style");
            style.type = "text/css";
            if (style.styleSheet) {
                style.styleSheet.cssText = code;
            } else {
                style.innerHTML = code;
            }
            document.getElementsByTagName("head")[0].appendChild(style);
        },
        loadCssFile: function(url) {
            var fileref = document.createElement("link");
            fileref.setAttribute("rel", "stylesheet");
            fileref.setAttribute("type", "text/css");
            fileref.setAttribute("href", url);
            document.getElementsByTagName("head")[0].appendChild(fileref);
        },
        loadScannerCssIfNotPresent: function() {
            var presents = false;
            var sc = document.getElementsByTagName("link");
            for (var idx = 0; idx < sc.length; idx++) {
                var s = sc.item(idx);
                if (s.href && s.href.match(/scannerjs\.css(\?\w*)?$/)) {
                    presents = true;
                }
            }
            if (!presents) {
                this.loadCssFile(this.getScannerJsBaseUrl() + "scannerjs.css");
            }
        },
        createWebSocket: function(wsUrl, onOpenFunc, onCloseFunc, onMesgFunc, onErrorFunc) {
            var websocket;
            if ("WebSocket" in window) {
                websocket = new WebSocket(wsUrl);
            } else {
                if ("MozWebSocket" in window) {
                    websocket = new MozWebSocket(wsUrl);
                } else {
                    return undefined;
                }
            }
            if (typeof onOpenFunc === "function") {
                websocket.onopen = function(event) {
                    onOpenFunc(websocket, event);
                };
            } else {
                this.logToConsole("No onOpenFunc specified for " + wsUrl);
                websocket.onopen = function(event) {
                    this.logToConsole("WebSocket [" + websocket.url + "] opens.");
                };
            }
            if (typeof onCloseFunc === "function") {
                websocket.onclose = function(event) {
                    onCloseFunc(websocket, event);
                };
            } else {
                this.logToConsole("No onCloseFunc specified for " + wsUrl);
                websocket.onclose = function(event) {
                    this.logToConsole("WebSocket [" + websocket.url + "] closes: " + event.code + " / " + event.reason + " / clean? " + event.wasClean);
                };
            }
            if (typeof onMesgFunc === "function") {
                websocket.onmessage = function(event) {
                    onMesgFunc(websocket, event);
                };
            } else {
                this.reportError("You must specify onMesgFunc for " + wsUrl);
                return undefined;
            }
            if (typeof onErrorFunc === "function") {
                websocket.onerror = function(event) {
                    onErrorFunc(websocket, event);
                };
            } else {
                websocket.onerror = function(event) {
                    scanner.logToConsole("WebSocket [" + websocket.url + "] error occurs:" + JSON.stringify(event));
                };
                if (scanner.scannerJsEventListener) {
                    scanner.scannerJsEventListener("disconnected", true);
                }
            }
            return websocket;
        },
        hasWebSocketSupport: function() {
            var isSupported = (("WebSocket" in window && window.WebSocket != undefined) || ("MozWebSocket" in window));
            if (!isSupported) {
                this.reportError("WebSocket is not supported by this browser: " + this.bowser.name + " " + this.bowser.version);
            }
            return isSupported;
        },
        isModernBrowser: function() {
            return typeof(atob) === "function" && typeof(ArrayBuffer) === "function" && typeof(Uint8Array) === "function" && typeof(Blob) === "function" && typeof(FormData) === "function";
        },
        base64ToUint8Array: function(base64) {
            if (!this.isModernBrowser()) {
                this.reportError("base64ToBlob() is not supported in legacy browsers.");
                return null;
            }
            if (base64 != null && base64.indexOf("data:") == 0) {
                var prefixEnd = "base64,";
                var suffixPos = base64.indexOf(prefixEnd);
                if (suffixPos > 0) {
                    base64 = base64.substr(suffixPos + prefixEnd.length);
                }
            }
            base64 = base64.replace(/(\r\n|\n|\r)/gm, "");
            var binary = atob(base64);
            var len = binary.length;
            var buffer = new ArrayBuffer(len);
            var view = new Uint8Array(buffer);
            for (var i = 0; i < len; i++) {
                view[i] = binary.charCodeAt(i);
            }
            return view;
        },
        base64ToBlob: function(base64, mimeType, fileName) {
            if (!this.isModernBrowser()) {
                this.reportError("base64ToBlob() is not supported in legacy browsers.");
                return null;
            }
            if (base64 != null && base64.indexOf("data:") == 0) {
                var semiColonPos = base64.indexOf(";");
                if (!mimeType && semiColonPos > 0) {
                    mimeType = base64.substring("data:".length, semiColonPos);
                }
                var prefixEnd = "base64,";
                var suffixPos = base64.indexOf(prefixEnd);
                if (suffixPos > 0) {
                    base64 = base64.substr(suffixPos + prefixEnd.length);
                }
            }
            base64 = base64.replace(/(\r\n|\n|\r)/gm, "");
            var binary = atob(base64);
            var len = binary.length;
            var buffer = new ArrayBuffer(len);
            var view = new Uint8Array(buffer);
            for (var i = 0; i < len; i++) {
                view[i] = binary.charCodeAt(i);
            }
            var blob = new Blob([view], {
                type: mimeType
            });
            if (fileName) {
                try {
                    blob.lastModifiedDate = new Date();
                    blob.name = fileName;
                } catch (e) {}
            }
            return blob;
        },
        getPageSessionId: function() {
            if (window.sessionStorage) {
                if (sessionStorage.getItem("pageLoadId")) {
                    pageLoadId = sessionStorage.getItem("pageLoadId");
                } else {
                    sessionStorage.setItem("pageLoadId", pageLoadId);
                }
            }
            return pageLoadId;
        },
        hasJava: function() {
            var jres = this.deployJava.getJREs();
            if (undefined == jres || jres == "" || ((jres instanceof Array) && jres.length == 0)) {
                return false;
            }
            return true;
        },
        displayEnableJavaHelp: function() {
            window.open("https://java.com/en/download/help/enable_browser.xml", "java-help");
        },
        is7u45: function() {
            return this.deployJava.versionCheck("1.7.0_45");
        },
        is7u45OrAbove: function() {
            return this.deployJava.versionCheck("1.7.0_45+");
        },
        doesCurrentBrowserSupportNPAPI: function() {
            if (!("version" in this.bowser)) {
                this.reportError("Invalid bowser");
                return false;
            }
            var versionInt = Math.floor(this.bowser.version);
            if (this.bowser.chrome) {
                return versionInt < 45;
            } else {
                if (this.bowser.firefox) {
                    return versionInt < 53;
                } else {
                    if (this.bowser.msedge) {
                        return false;
                    } else {
                        if (this.bowser.msie) {
                            return true;
                        } else {
                            return false;
                        }
                    }
                }
            }
        },
        getMimeType: function(format) {
            if (format == null) {
                return this.MIME_TYPE_BINARY;
            }
            if (format.toLowerCase().indexOf("bmp") >= 0) {
                return "image/bmp";
            } else {
                if (format.toLowerCase().indexOf("png") >= 0) {
                    return "image/png";
                } else {
                    if (format.toLowerCase().indexOf("jp") >= 0) {
                        return "image/jpeg";
                    } else {
                        if (format.toLowerCase().indexOf("tif") >= 0) {
                            return "image/tiff";
                        } else {
                            if (format.toLowerCase().indexOf("pdf") >= 0) {
                                return "application/pdf";
                            }
                        }
                    }
                }
            }
            return "application/octet-stream";
        },
        getFileExtension: function(format) {
            if (format == null) {
                return "unknown";
            }
            if (format.toLowerCase().indexOf("bmp") >= 0) {
                return "bmp";
            } else {
                if (format.toLowerCase().indexOf("png") >= 0) {
                    return "png";
                } else {
                    if (format.toLowerCase().indexOf("jp") >= 0) {
                        return "jpg";
                    } else {
                        if (format.toLowerCase().indexOf("tif") >= 0) {
                            return "tif";
                        } else {
                            if (format.toLowerCase().indexOf("pdf") >= 0) {
                                return "pdf";
                            }
                        }
                    }
                }
            }
            return "unknown";
        },
        generateFileName: function(format) {
            var extension = this.getFileExtension(format);
            var name = "asprise-scannerjs-" + (++this.fileCount) + "." + extension;
            return name;
        },
        removeFragmentFromUrl: function(url) {
            if (url == null) {
                return url;
            }
            var posHash = url.indexOf("#");
            if (posHash >= 0) {
                return url.substr(0, posHash);
            }
            return url;
        },
        createDomElement: function(tagName, attrs) {
            var element = document.createElement(tagName);
            if (attrs != null) {
                for (var attr in attrs) {
                    element.setAttribute(attr, attrs[attr]);
                }
            }
            var text = attrs != null && ("text" in attrs) ? attrs["text"] : undefined;
            if (text) {
                element.appendChild(document.createTextNode(text));
            }
            return element;
        },
        createDomElementFromModel: function(assocArray) {
            var element = this.createDomElement(assocArray["name"], assocArray["attributes"]);
            if (assocArray["children"] instanceof Array) {
                var children = assocArray["children"];
                for (var c = 0; c < children.length; c++) {
                    if (children[c]) {
                        element.appendChild(this.createDomElementFromModel(children[c]));
                    }
                }
            }
            return element;
        },
        createAppletDomElement: function(id, codebase, archive, className, width, height) {
            var appletModel = {
                "name": "applet",
                "attributes": {
                    "id": id,
                    "codebase": codebase,
                    "archive": archive,
                    "code": className,
                    "width": width,
                    "height": height,
                    "style": "z-index: -999;"
                },
                "children": [{
                    "name": "param",
                    "attributes": {
                        "name": "permissions",
                        "value": "all-permissions"
                    }
                }, {
                    "name": "param",
                    "attributes": {
                        "name": "java_version",
                        "value": "1.6+"
                    }
                }, {
                    "name": "param",
                    "attributes": {
                        "name": "java_arguments",
                        "value": "-Xmx512m"
                    }
                }, {
                    "name": "param",
                    "attributes": {
                        "name": "separate_jvm",
                        "value": "true"
                    }
                }, {
                    "name": "param",
                    "attributes": {
                        "name": "codebase_lookup",
                        "value": "false"
                    }
                }, {
                    "name": "param",
                    "attributes": {
                        "name": "mayscript",
                        "value": "mayscript"
                    }
                }]
            };
            return this.createDomElementFromModel(appletModel);
        },
        setElementStyleDisplay: function(element, displayType) {
            if (!element) {
                this.reportError("Not an element: " + element);
                return;
            }
            var style = element.getAttribute("style");
            if (style) {
                element.setAttribute("style", style.replace(/display:\s*[^;]*/, "display: " + displayType));
            } else {
                element.setAttribute("style", "display: " + displayType + ";");
            }
        },
        logToConsole: function(mesg, isError) {
            if (window.console) {
                var dateStr = new Date().toLocaleTimeString();
                if (isError) {
                    if (console.error) {
                        console.error(dateStr + " " + mesg);
                    } else {
                        console.log(dateStr + " " + "ERROR: " + mesg);
                    }
                } else {
                    if (console.info) {
                        console.info(dateStr + " " + mesg);
                    } else {
                        console.log(dateStr + "" + " INFO: " + mesg);
                    }
                }
            } else {
                if (isError) {
                    if (window.alert) {
                        alert("ERROR: " + mesg);
                    }
                }
            }
        },
        reportError: function(mesg) {
            this.logToConsole(mesg, true);
        },
        isHttps: function() {
            return "https:" == document.location.protocol;
        },
        isWindows: function() {
            if (("navigator" in window && window.navigator != undefined) && ("platform" in window.navigator)) {
                return navigator.platform.indexOf("Win") > -1;
            } else {
                return undefined;
            }
        },
        getCookie: function(name) {
            var value = "; " + document.cookie;
            var parts = value.split("; " + name + "=");
            if (parts.length == 2) {
                return parts.pop().split(";").shift();
            }
            return undefined;
        },
        setCookie: function(name, value, sessionOnly) {
            document.cookie = name + "=" + value + (sessionOnly ? "" : "; expires=Fri, 31 Dec 2066 23:59:59 GMT");
        },
        writeToLocalStorage: function(name, value) {
            if (!window.localStorage) {
                return false;
            }
            try {
                window.localStorage.setItem(name, value);
                return true;
            } catch (e) {
                return false;
            }
        },
        readFromLocalStorage: function(name) {
            if (!window.localStorage) {
                return undefined;
            }
            try {
                return window.localStorage.getItem(name);
            } catch (e) {
                return undefined;
            }
        },
        deployJava: function() {
            function e(e) {
                h.debug && (console.log ? console.log(e) : alert(e));
            }

            function t(e, t) {
                if (null == e || 0 == e.length) {
                    return !0;
                }
                var n = e.charAt(e.length - 1);
                if ("+" != n && "*" != n && -1 != e.indexOf("_") && "_" != n && (e += "*", n = "*"), e = e.substring(0, e.length - 1), e.length > 0) {
                    var i = e.charAt(e.length - 1);
                    ("." == i || "_" == i) && (e = e.substring(0, e.length - 1));
                }
                return "*" == n ? 0 == t.indexOf(e) : "+" == n ? t >= e : !1;
            }

            function n() {
                var e = "//java.com/js/webstart.png";
                try {
                    return -1 != document.location.protocol.indexOf("http") ? e : "http:" + e;
                } catch (t) {
                    return "http:" + e;
                }
            }

            function i(e) {
                var t = "http://java.com/dt-redirect";
                return null == e || 0 == e.length ? t : ("&" == e.charAt(0) && (e = e.substring(1, e.length)), t + "?" + e);
            }

            function r(e, t) {
                for (var n = e.length, i = 0; n > i; i++) {
                    if (e[i] === t) {
                        return !0;
                    }
                }
                return !1;
            }

            function a(e) {
                return r(u, e.toLowerCase());
            }

            function l(e) {
                return "MSIE" != deployJava.browserName ? !0 : deployJava.compareVersionToPattern(deployJava.getPlugin().version, ["10", "0", "0"], !1, !0) ? !0 : null == e ? !1 : !t("1.6.0_33+", e);
            }
            var o = {
                    core: ["id", "class", "title", "style"],
                    i18n: ["lang", "dir"],
                    events: ["onclick", "ondblclick", "onmousedown", "onmouseup", "onmouseover", "onmousemove", "onmouseout", "onkeypress", "onkeydown", "onkeyup"],
                    applet: ["codebase", "code", "name", "archive", "object", "width", "height", "alt", "align", "hspace", "vspace"],
                    object: ["classid", "codebase", "codetype", "data", "type", "archive", "declare", "standby", "height", "width", "usemap", "name", "tabindex", "align", "border", "hspace", "vspace"]
                },
                u = (o.object.concat(o.core, o.i18n, o.events), o.applet.concat(o.core)),
                h = {
                    debug: null,
                    version: "20120801",
                    firefoxJavaVersion: null,
                    myInterval: null,
                    preInstallJREList: null,
                    returnPage: null,
                    brand: null,
                    locale: null,
                    installType: null,
                    EAInstallEnabled: !1,
                    EarlyAccessURL: null,
                    oldMimeType: "application/npruntime-scriptable-plugin;DeploymentToolkit",
                    mimeType: "application/java-deployment-toolkit",
                    launchButtonPNG: n(),
                    browserName: null,
                    browserName2: null,
                    getJREs: function() {
                        var t = new Array;
                        if (this.isPluginInstalled()) {
                            for (var n = this.getPlugin(), i = n.jvms, r = 0; r < i.getLength(); r++) {
                                t[r] = i.get(r).version;
                            }
                        } else {
                            var a = this.getBrowser();
                            "MSIE" == a ? this.testUsingActiveX("1.7.0") ? t[0] = "1.7.0" : this.testUsingActiveX("1.6.0") ? t[0] = "1.6.0" : this.testUsingActiveX("1.5.0") ? t[0] = "1.5.0" : this.testUsingActiveX("1.4.2") ? t[0] = "1.4.2" : this.testForMSVM() && (t[0] = "1.1") : "Netscape Family" == a && (this.getJPIVersionUsingMimeType(), null != this.firefoxJavaVersion ? t[0] = this.firefoxJavaVersion : this.testUsingMimeTypes("1.7") ? t[0] = "1.7.0" : this.testUsingMimeTypes("1.6") ? t[0] = "1.6.0" : this.testUsingMimeTypes("1.5") ? t[0] = "1.5.0" : this.testUsingMimeTypes("1.4.2") ? t[0] = "1.4.2" : "Safari" == this.browserName2 && (this.testUsingPluginsArray("1.7.0") ? t[0] = "1.7.0" : this.testUsingPluginsArray("1.6") ? t[0] = "1.6.0" : this.testUsingPluginsArray("1.5") ? t[0] = "1.5.0" : this.testUsingPluginsArray("1.4.2") && (t[0] = "1.4.2")));
                        }
                        if (this.debug) {
                            for (var r = 0; r < t.length; ++r) {
                                e("[getJREs()] We claim to have detected Java SE " + t[r]);
                            }
                        }
                        return t;
                    },
                    installJRE: function(e, t) {
                        if (this.isPluginInstalled() && this.isAutoInstallEnabled(e)) {
                            var n = !1;
                            return n = this.isCallbackSupported() ? this.getPlugin().installJRE(e, t) : this.getPlugin().installJRE(e), n && (this.refresh(), null != this.returnPage && (document.location = this.returnPage)), n;
                        }
                        return this.installLatestJRE();
                    },
                    isAutoInstallEnabled: function(e) {
                        return this.isPluginInstalled() ? ("undefined" == typeof e && (e = null), l(e)) : !1;
                    },
                    isCallbackSupported: function() {
                        return this.isPluginInstalled() && this.compareVersionToPattern(this.getPlugin().version, ["10", "2", "0"], !1, !0);
                    },
                    installLatestJRE: function(e) {
                        if (this.isPluginInstalled() && this.isAutoInstallEnabled()) {
                            var t = !1;
                            return t = this.isCallbackSupported() ? this.getPlugin().installLatestJRE(e) : this.getPlugin().installLatestJRE(), t && (this.refresh(), null != this.returnPage && (document.location = this.returnPage)), t;
                        }
                        var n = this.getBrowser(),
                            r = navigator.platform.toLowerCase();
                        return "true" == this.EAInstallEnabled && -1 != r.indexOf("win") && null != this.EarlyAccessURL ? (this.preInstallJREList = this.getJREs(), null != this.returnPage && (this.myInterval = setInterval("deployJava.poll()", 3000)), location.href = this.EarlyAccessURL, !1) : "MSIE" == n ? this.IEInstall() : "Netscape Family" == n && -1 != r.indexOf("win32") ? this.FFInstall() : (location.href = i((null != this.returnPage ? "&returnPage=" + this.returnPage : "") + (null != this.locale ? "&locale=" + this.locale : "") + (null != this.brand ? "&brand=" + this.brand : "")), !1);
                    },
                    runApplet: function(t, n, i) {
                        ("undefined" == i || null == i) && (i = "1.1");
                        var r = i.match(version_regex_strict);
                        if (null == this.returnPage && (this.returnPage = document.location), null != r) {
                            var a = this.getBrowser();
                            "?" != a ? this.versionCheck(i + "+") ? this.writeAppletTag(t, n) : this.installJRE(i + "+") && (this.refresh(), location.href = document.location, this.writeAppletTag(t, n)) : this.writeAppletTag(t, n);
                        } else {
                            e("[runApplet()] Invalid minimumVersion argument to runApplet():" + i);
                        }
                    },
                    writeAppletTag: function(e, t) {
                        var n = "<applet ",
                            i = "",
                            r = "</applet>",
                            s = !0;
                        (null == t || "object" != typeof t) && (t = new Object);
                        for (var l in e) {
                            a(l) ? (n += " " + l + '="' + e[l] + '"', "code" == l && (s = !1)) : t[l] = e[l];
                        }
                        var o = !1;
                        for (var u in t) {
                            "codebase_lookup" == u && (o = !0), ("object" == u || "java_object" == u || "java_code" == u) && (s = !1), i += '<param name="' + u + '" value="' + t[u] + '"/>';
                        }
                        o || (i += '<param name="codebase_lookup" value="false"/>'), s && (n += ' code="dummy"'), n += ">", document.write(n + "\n" + i + "\n" + r);
                    },
                    versionCheck: function(t) {
                        var n = 0,
                            i = t.match(version_regex_with_family_modifier);
                        if (null != i) {
                            for (var r = !1, a = !1, s = new Array, l = 1; l < i.length; ++l) {
                                "string" == typeof i[l] && "" != i[l] && (s[n] = i[l], n++);
                            }
                            "+" == s[s.length - 1] ? (a = !0, r = !1, s.length--) : "*" == s[s.length - 1] ? (a = !1, r = !0, s.length--) : s.length < 4 && (a = !1, r = !0);
                            for (var o = this.getJREs(), l = 0; l < o.length; ++l) {
                                if (this.compareVersionToPattern(o[l], s, r, a)) {
                                    return !0;
                                }
                            }
                            return !1;
                        }
                        var u = "Invalid versionPattern passed to versionCheck: " + t;
                        return e("[versionCheck()] " + u), alert(u), !1;
                    },
                    isWebStartInstalled: function(t) {
                        var n = this.getBrowser();
                        if ("?" == n) {
                            return !0;
                        }("undefined" == t || null == t) && (t = "1.4.2");
                        var i = !1,
                            r = t.match(version_regex_strict);
                        return null != r ? i = this.versionCheck(t + "+") : (e("[isWebStartInstaller()] Invalid minimumVersion argument to isWebStartInstalled(): " + t), i = this.versionCheck("1.4.2+")), i;
                    },
                    getJPIVersionUsingMimeType: function() {
                        for (var e = 0; e < navigator.mimeTypes.length; ++e) {
                            var t = navigator.mimeTypes[e].type,
                                n = t.match(/^application\/x-java-applet;jpi-version=(.*)$/);
                            if (null != n && (this.firefoxJavaVersion = n[1], "Opera" != this.browserName2)) {
                                break;
                            }
                        }
                    },
                    launchWebStartApplication: function(e) {
                        navigator.userAgent.toLowerCase();
                        if (this.getJPIVersionUsingMimeType(), 0 == this.isWebStartInstalled("1.7.0") && (0 == this.installJRE("1.7.0+") || 0 == this.isWebStartInstalled("1.7.0"))) {
                            return !1;
                        }
                        var t = null;
                        document.documentURI && (t = document.documentURI), null == t && (t = document.URL);
                        var n, i = this.getBrowser();
                        if ("MSIE" == i ? n = '<object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" width="0" height="0"><PARAM name="launchjnlp" value="' + e + '"><PARAM name="docbase" value="' + encodeURIComponent(t) + '"></object>' : "Netscape Family" == i && (n = '<embed type="application/x-java-applet;jpi-version=' + this.firefoxJavaVersion + '" width="0" height="0" launchjnlp="' + e + '"docbase="' + encodeURIComponent(t) + '" />'), "undefined" == document.body || null == document.body) {
                            document.write(n), document.location = t;
                        } else {
                            var r = document.createElement("div");
                            r.id = "div1", r.style.position = "relative", r.style.left = "-10000px", r.style.margin = "0px auto", r.className = "dynamicDiv", r.innerHTML = n, document.body.appendChild(r);
                        }
                    },
                    createWebStartLaunchButtonEx: function(e, t) {
                        null == this.returnPage && (this.returnPage = e);
                        var n = "javascript:deployJava.launchWebStartApplication('" + e + "');";
                        document.write('<a href="' + n + '" onMouseOver="window.status=\'\'; return true;"><img src="' + this.launchButtonPNG + '" border="0" /></a>');
                    },
                    createWebStartLaunchButton: function(e, t) {
                        null == this.returnPage && (this.returnPage = e);
                        var n = "javascript:if (!deployJava.isWebStartInstalled(&quot;" + t + "&quot;)) {if (deployJava.installLatestJRE()) {if (deployJava.launch(&quot;" + e + "&quot;)) {}}} else {if (deployJava.launch(&quot;" + e + "&quot;)) {}}";
                        document.write('<a href="' + n + '" onMouseOver="window.status=\'\'; return true;"><img src="' + this.launchButtonPNG + '" border="0" /></a>');
                    },
                    launch: function(e) {
                        return document.location = e, !0;
                    },
                    isPluginInstalled: function() {
                        var e = this.getPlugin();
                        return e && e.jvms ? !0 : !1;
                    },
                    isAutoUpdateEnabled: function() {
                        return this.isPluginInstalled() ? this.getPlugin().isAutoUpdateEnabled() : !1;
                    },
                    setAutoUpdateEnabled: function() {
                        return this.isPluginInstalled() ? this.getPlugin().setAutoUpdateEnabled() : !1;
                    },
                    setInstallerType: function(e) {
                        return this.installType = e, this.isPluginInstalled() ? this.getPlugin().setInstallerType(e) : !1;
                    },
                    setAdditionalPackages: function(e) {
                        return this.isPluginInstalled() ? this.getPlugin().setAdditionalPackages(e) : !1;
                    },
                    setEarlyAccess: function(e) {
                        this.EAInstallEnabled = e;
                    },
                    isPlugin2: function() {
                        if (this.isPluginInstalled() && this.versionCheck("1.6.0_10+")) {
                            try {
                                return this.getPlugin().isPlugin2();
                            } catch (e) {}
                        }
                        return !1;
                    },
                    allowPlugin: function() {
                        this.getBrowser();
                        var e = "Safari" != this.browserName2 && "Opera" != this.browserName2;
                        return e;
                    },
                    getPlugin: function() {
                        this.refresh();
                        var e = null;
                        return this.allowPlugin() && (e = document.getElementById("deployJavaPlugin")), e;
                    },
                    compareVersionToPattern: function(e, t, n, i) {
                        if (void 0 == e || void 0 == t) {
                            return !1;
                        }
                        var r = e.match(version_regex_strict);
                        if (null != r) {
                            for (var a = 0, s = new Array, l = 1; l < r.length; ++l) {
                                "string" == typeof r[l] && "" != r[l] && (s[a] = r[l], a++);
                            }
                            var o = Math.min(s.length, t.length);
                            if (i) {
                                for (var l = 0; o > l; ++l) {
                                    var u = parseInt(s[l]),
                                        h = parseInt(t[l]);
                                    if (h > u) {
                                        return !1;
                                    }
                                    if (u > h) {
                                        return !0;
                                    }
                                }
                                return !0;
                            }
                            for (var l = 0; o > l; ++l) {
                                if (s[l] != t[l]) {
                                    return !1;
                                }
                            }
                            return n ? !0 : s.length == t.length;
                        }
                        return !1;
                    },
                    getBrowser: function() {
                        if (null == this.browserName) {
                            var t = navigator.userAgent.toLowerCase();
                            e("[getBrowser()] navigator.userAgent.toLowerCase() -> " + t), -1 != t.indexOf("msie") && -1 == t.indexOf("opera") ? (this.browserName = "MSIE", this.browserName2 = "MSIE") : -1 != t.indexOf("trident") || -1 != t.indexOf("Trident") ? (this.browserName = "MSIE", this.browserName2 = "MSIE") : -1 != t.indexOf("iphone") ? (this.browserName = "Netscape Family", this.browserName2 = "iPhone") : -1 != t.indexOf("firefox") && -1 == t.indexOf("opera") ? (this.browserName = "Netscape Family", this.browserName2 = "Firefox") : -1 != t.indexOf("chrome") ? (this.browserName = "Netscape Family", this.browserName2 = "Chrome") : -1 != t.indexOf("safari") ? (this.browserName = "Netscape Family", this.browserName2 = "Safari") : -1 != t.indexOf("mozilla") && -1 == t.indexOf("opera") ? (this.browserName = "Netscape Family", this.browserName2 = "Other") : -1 != t.indexOf("opera") ? (this.browserName = "Netscape Family", this.browserName2 = "Opera") : (this.browserName = "?", this.browserName2 = "unknown"), e("[getBrowser()] Detected browser name:" + this.browserName + ", " + this.browserName2);
                        }
                        return this.browserName;
                    },
                    testUsingActiveX: function(t) {
                        var n = "JavaWebStart.isInstalled." + t + ".0";
                        if ("undefined" == typeof ActiveXObject || !ActiveXObject) {
                            return e("[testUsingActiveX()] Browser claims to be IE, but no ActiveXObject object?"), !1;
                        }
                        try {
                            return null != new ActiveXObject(n);
                        } catch (i) {
                            return !1;
                        }
                    },
                    testForMSVM: function() {
                        var e = "{08B0E5C0-4FCB-11CF-AAA5-00401C608500}";
                        if ("undefined" != typeof oClientCaps) {
                            var t = oClientCaps.getComponentVersion(e, "ComponentID");
                            return "" == t || "5,0,5000,0" == t ? !1 : !0;
                        }
                        return !1;
                    },
                    testUsingMimeTypes: function(t) {
                        if (!navigator.mimeTypes) {
                            return e("[testUsingMimeTypes()] Browser claims to be Netscape family, but no mimeTypes[] array?"), !1;
                        }
                        for (var n = 0; n < navigator.mimeTypes.length; ++n) {
                            s = navigator.mimeTypes[n].type;
                            var i = s.match(/^application\/x-java-applet\x3Bversion=(1\.8|1\.7|1\.6|1\.5|1\.4\.2)$/);
                            if (null != i && this.compareVersions(i[1], t)) {
                                return !0;
                            }
                        }
                        return !1;
                    },
                    testUsingPluginsArray: function(e) {
                        if (!navigator.plugins || !navigator.plugins.length) {
                            return !1;
                        }
                        for (var t = navigator.platform.toLowerCase(), n = 0; n < navigator.plugins.length; ++n) {
                            if (s = navigator.plugins[n].description, -1 != s.search(/^Java Switchable Plug-in (Cocoa)/)) {
                                if (this.compareVersions("1.5.0", e)) {
                                    return !0;
                                }
                            } else {
                                if (-1 != s.search(/^Java/) && -1 != t.indexOf("win") && (this.compareVersions("1.5.0", e) || this.compareVersions("1.6.0", e))) {
                                    return !0;
                                }
                            }
                        }
                        return this.compareVersions("1.5.0", e) ? !0 : !1;
                    },
                    IEInstall: function() {
                        return location.href = i((null != this.returnPage ? "&returnPage=" + this.returnPage : "") + (null != this.locale ? "&locale=" + this.locale : "") + (null != this.brand ? "&brand=" + this.brand : "")), !1;
                    },
                    done: function(e, t) {},
                    FFInstall: function() {
                        return location.href = i((null != this.returnPage ? "&returnPage=" + this.returnPage : "") + (null != this.locale ? "&locale=" + this.locale : "") + (null != this.brand ? "&brand=" + this.brand : "") + (null != this.installType ? "&type=" + this.installType : "")), !1;
                    },
                    compareVersions: function(e, t) {
                        for (var n = e.split("."), i = t.split("."), r = 0; r < n.length; ++r) {
                            n[r] = Number(n[r]);
                        }
                        for (var r = 0; r < i.length; ++r) {
                            i[r] = Number(i[r]);
                        }
                        return 2 == n.length && (n[2] = 0), n[0] > i[0] ? !0 : n[0] < i[0] ? !1 : n[1] > i[1] ? !0 : n[1] < i[1] ? !1 : n[2] > i[2] ? !0 : n[2] < i[2] ? !1 : !0;
                    },
                    enableAlerts: function() {
                        this.browserName = null, this.debug = !0;
                    },
                    poll: function() {
                        this.refresh();
                        var e = this.getJREs();
                        0 == this.preInstallJREList.length && 0 != e.length && (clearInterval(this.myInterval), null != this.returnPage && (location.href = this.returnPage)), 0 != this.preInstallJREList.length && 0 != e.length && this.preInstallJREList[0] != e[0] && (clearInterval(this.myInterval), null != this.returnPage && (location.href = this.returnPage));
                    },
                    writePluginTag: function() {
                        var e = this.getBrowser();
                        if ("MSIE" == e) {
                            var t = {
                                name: "object",
                                attributes: {
                                    id: "deployJavaPlugin",
                                    classid: "clsid:CAFEEFAC-DEC7-0000-0001-ABCDEFFEDCBA",
                                    width: "0",
                                    height: "0"
                                }
                            };
                            modelsToAppendToBodyFromDeployJava.push(t);
                        } else {
                            "Netscape Family" == e && this.allowPlugin() && this.writeEmbedTag();
                        }
                    },
                    refresh: function() {
                        navigator.plugins.refresh(!1);
                        var e = this.getBrowser();
                        if ("Netscape Family" == e && this.allowPlugin()) {
                            var t = document.getElementById("deployJavaPlugin");
                            null == t && this.writeEmbedTag();
                        }
                    },
                    writeEmbedTag: function() {
                        var e = !1;
                        if (null != navigator.mimeTypes) {
                            for (var t = 0; t < navigator.mimeTypes.length; t++) {
                                if (navigator.mimeTypes[t].type == this.mimeType && navigator.mimeTypes[t].enabledPlugin) {
                                    var n = {
                                        name: "embed",
                                        attributes: {
                                            id: "deployJavaPlugin",
                                            type: this.mimeType,
                                            hidden: "true"
                                        }
                                    };
                                    modelsToAppendToBodyFromDeployJava.push(n), e = !0;
                                }
                            }
                            if (!e) {
                                for (var t = 0; t < navigator.mimeTypes.length; t++) {
                                    if (navigator.mimeTypes[t].type == this.oldMimeType && navigator.mimeTypes[t].enabledPlugin) {
                                        ({
                                            name: "embed",
                                            attributes: {
                                                id: "deployJavaPlugin",
                                                type: this.oldMimeType,
                                                hidden: "true"
                                            }
                                        });
                                        modelsToAppendToBodyFromDeployJava.push(oldMimeType);
                                    }
                                }
                            }
                        }
                    }
                };
            if (h.writePluginTag(), null == h.locale) {
                var c = null;
                if (null == c) {
                    try {
                        c = navigator.userLanguage;
                    } catch (g) {}
                }
                if (null == c) {
                    try {
                        c = navigator.systemLanguage;
                    } catch (g) {}
                }
                if (null == c) {
                    try {
                        c = navigator.language;
                    } catch (g) {}
                }
                null != c && (c.replace("-", "_"), h.locale = c);
            }
            return h;
        }(),
        appendDeployJavaElementsToBody: function() {
            if (modelsToAppendToBodyFromDeployJava.length == 0) {
                return;
            }
            var elementBodyList = document.getElementsByTagName("body");
            var elementBody = (elementBodyList != null && elementBodyList.length > 0) ? elementBodyList.item(0) : null;
            if (elementBody == null) {
                this.reportError("Unexcepted error - unable to get body");
                return false;
            }
            for (var m = 0; m < modelsToAppendToBodyFromDeployJava.length; m++) {
                var model = modelsToAppendToBodyFromDeployJava[m];
                elementBody.appendChild(this.createDomElementFromModel(model));
            }
        },
        bowser: (function() {
            function t(t) {
                function n(e) {
                    var n = t.match(e);
                    return n && n.length > 1 && n[1] || "";
                }

                function r(e) {
                    var n = t.match(e);
                    return n && n.length > 1 && n[2] || "";
                }
                var i = n(/(ipod|iphone|ipad)/i).toLowerCase(),
                    s = /like android/i.test(t),
                    o = !s && /android/i.test(t),
                    u = /CrOS/.test(t),
                    a = n(/edge\/(\d+(\.\d+)?)/i),
                    f = n(/version\/(\d+(\.\d+)?)/i),
                    l = /tablet/i.test(t),
                    c = !l && /[^-]mobi/i.test(t),
                    h;
                /opera|opr/i.test(t) ? h = {
                    name: "Opera",
                    opera: e,
                    version: f || n(/(?:opera|opr)[\s\/](\d+(\.\d+)?)/i)
                } : /yabrowser/i.test(t) ? h = {
                    name: "Yandex Browser",
                    yandexbrowser: e,
                    version: f || n(/(?:yabrowser)[\s\/](\d+(\.\d+)?)/i)
                } : /windows phone/i.test(t) ? (h = {
                    name: "Windows Phone",
                    windowsphone: e
                }, a ? (h.msedge = e, h.version = a) : (h.msie = e, h.version = n(/iemobile\/(\d+(\.\d+)?)/i))) : /msie|trident/i.test(t) ? h = {
                    name: "Internet Explorer",
                    msie: e,
                    version: n(/(?:msie |rv:)(\d+(\.\d+)?)/i)
                } : u ? h = {
                    name: "Chrome",
                    chromeBook: e,
                    chrome: e,
                    version: n(/(?:chrome|crios|crmo)\/(\d+(\.\d+)?)/i)
                } : /chrome.+? edge/i.test(t) ? h = {
                    name: "Microsoft Edge",
                    msedge: e,
                    version: a
                } : /chrome|crios|crmo/i.test(t) ? h = {
                    name: "Chrome",
                    chrome: e,
                    version: n(/(?:chrome|crios|crmo)\/(\d+(\.\d+)?)/i)
                } : i ? (h = {
                    name: i == "iphone" ? "iPhone" : i == "ipad" ? "iPad" : "iPod"
                }, f && (h.version = f)) : /sailfish/i.test(t) ? h = {
                    name: "Sailfish",
                    sailfish: e,
                    version: n(/sailfish\s?browser\/(\d+(\.\d+)?)/i)
                } : /seamonkey\//i.test(t) ? h = {
                    name: "SeaMonkey",
                    seamonkey: e,
                    version: n(/seamonkey\/(\d+(\.\d+)?)/i)
                } : /firefox|iceweasel/i.test(t) ? (h = {
                    name: "Firefox",
                    firefox: e,
                    version: n(/(?:firefox|iceweasel)[ \/](\d+(\.\d+)?)/i)
                }, /\((mobile|tablet);[^\)]*rv:[\d\.]+\)/i.test(t) && (h.firefoxos = e)) : /silk/i.test(t) ? h = {
                    name: "Amazon Silk",
                    silk: e,
                    version: n(/silk\/(\d+(\.\d+)?)/i)
                } : o ? h = {
                    name: "Android",
                    version: f
                } : /phantom/i.test(t) ? h = {
                    name: "PhantomJS",
                    phantom: e,
                    version: n(/phantomjs\/(\d+(\.\d+)?)/i)
                } : /blackberry|\bbb\d+/i.test(t) || /rim\stablet/i.test(t) ? h = {
                    name: "BlackBerry",
                    blackberry: e,
                    version: f || n(/blackberry[\d]+\/(\d+(\.\d+)?)/i)
                } : /(web|hpw)os/i.test(t) ? (h = {
                    name: "WebOS",
                    webos: e,
                    version: f || n(/w(?:eb)?osbrowser\/(\d+(\.\d+)?)/i)
                }, /touchpad\//i.test(t) && (h.touchpad = e)) : /bada/i.test(t) ? h = {
                    name: "Bada",
                    bada: e,
                    version: n(/dolfin\/(\d+(\.\d+)?)/i)
                } : /tizen/i.test(t) ? h = {
                    name: "Tizen",
                    tizen: e,
                    version: n(/(?:tizen\s?)?browser\/(\d+(\.\d+)?)/i) || f
                } : /safari/i.test(t) ? h = {
                    name: "Safari",
                    safari: e,
                    version: f
                } : h = {
                    name: n(/^(.*)\/(.*) /),
                    version: r(/^(.*)\/(.*) /)
                }, !h.msedge && /(apple)?webkit/i.test(t) ? (h.name = h.name || "Webkit", h.webkit = e, !h.version && f && (h.version = f)) : !h.opera && /gecko\//i.test(t) && (h.name = h.name || "Gecko", h.gecko = e, h.version = h.version || n(/gecko\/(\d+(\.\d+)?)/i)), !h.msedge && (o || h.silk) ? h.android = e : i && (h[i] = e, h.ios = e);
                var p = "";
                h.windowsphone ? p = n(/windows phone (?:os)?\s?(\d+(\.\d+)*)/i) : i ? (p = n(/os (\d+([_\s]\d+)*) like mac os x/i), p = p.replace(/[_\s]/g, ".")) : o ? p = n(/android[ \/-](\d+(\.\d+)*)/i) : h.webos ? p = n(/(?:web|hpw)os\/(\d+(\.\d+)*)/i) : h.blackberry ? p = n(/rim\stablet\sos\s(\d+(\.\d+)*)/i) : h.bada ? p = n(/bada\/(\d+(\.\d+)*)/i) : h.tizen && (p = n(/tizen[\/\s](\d+(\.\d+)*)/i)), p && (h.osversion = p);
                var d = p.split(".")[0];
                if (l || i == "ipad" || o && (d == 3 || d == 4 && !c) || h.silk) {
                    h.tablet = e;
                } else {
                    if (c || i == "iphone" || i == "ipod" || o || h.blackberry || h.webos || h.bada) {
                        h.mobile = e;
                    }
                }
                return h.msedge || h.msie && h.version >= 10 || h.yandexbrowser && h.version >= 15 || h.chrome && h.version >= 20 || h.firefox && h.version >= 20 || h.safari && h.version >= 6 || h.opera && h.version >= 10 || h.ios && h.osversion && h.osversion.split(".")[0] >= 6 || h.blackberry && h.version >= 10.1 ? h.a = e : h.msie && h.version < 10 || h.chrome && h.version < 20 || h.firefox && h.version < 20 || h.safari && h.version < 6 || h.opera && h.version < 10 || h.ios && h.osversion && h.osversion.split(".")[0] < 6 ? h.c = e : h.x = e, h;
            }
            var e = !0,
                n = t(typeof navigator != "undefined" ? navigator.userAgent : "");
            return n.test = function(e) {
                for (var t = 0; t < e.length; ++t) {
                    var r = e[t];
                    if (typeof r == "string" && r in n) {
                        return !0;
                    }
                }
                return !1;
            }, n._detect = t, n;
        }())
    };
    if (window) {
        if (window.addEventListener) {
            window.addEventListener("load", function() {
                if (scannerDef.eagerInitialization) {
                    scannerDef.initialize();
                }
            });
        } else {
            if (window.attachEvent) {
                window.attachEvent("onload", function() {
                    if (scannerDef.eagerInitialization) {
                        scannerDef.initialize();
                    }
                });
            }
        }
    }
    return scannerDef;
});