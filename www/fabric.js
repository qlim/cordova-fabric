"use strict";

var exec = require('cordova/exec');

var Fabric = function() {
  this.crashlytics = new Crashlytics();
}

var Crashlytics = function() {
  var methods = [
    'logException', 'log', 'setBool', 'setDouble', 'setFloat', 'setInt',
    'setLong', 'setString', 'setUserEmail', 'setUserIdentifier',
    'setUserName', 'crash'
  ];

  var execCall;
  var rippleMock = (window.parent && window.parent.ripple);
  if(rippleMock) {
    console.warn("navigator.fabric.crashlytics not defined : considering you're in dev mode and mocking it !");
    execCall = function(methodName, args){ console.log("[Fabric] Call to " + methodName + "("+Array.prototype.join.apply(args, [", "])+")"); }
  } else {
    execCall = function(methodName, args){ exec(null, null, "Fabric", methodName, args); };
  }

  var self = this;
  for(var i=0; i<methods.length; i++) {
    // Wrapping the callback definition call into a temporary function, otherwise i will always
    // be set to methods.length when calling execCall()
    (function(idx){
      var currentMethod = methods[idx];
      self[currentMethod] = function(){
        execCall(currentMethod,  Array.prototype.slice.call(arguments));
      };
    })(i);
  }

  this.LOG_LEVELS = {
    VERBOSE: 2,
    DEBUG: 3,
    INFO: 4,
    WARN: 5,
    ERROR: 6,
    ASSERT: 7
  };
};

var fabric = new Fabric();

module.exports = fabric;
