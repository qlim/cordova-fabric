# co.flocode.cordova.fabric

This plugin provides a bridge between javascript error handling and [Fabric](https://www.fabric.io/) serverside
client API. It is based heavily on the initial work done by [smistry-toushay](https://github.com/smistry-toushay/cordova-crashlytics-plugin) and [4sh-projects](https://github.com/4sh-projects/cordova-crashlytics-plugin).

## Installation

```sh
cordova plugin add https://github.com/lookitsatravis/cordova-fabric --variable FABRIC_API_SECRET=<YOUR FABRIC API SECRET HERE> --variable FABRIC_API_KEY=<YOUR FABRIC API KEY HERE>
```

## Features

* Crashlytics interface
* iOS Support
* Android Support

## Crashlytics

Plugins provides a `navigator.fabric.crashlytics` object with following methods :
- logException(string) : Sends an exception (non fatal) to the Crashlytics backend
- log(string) : Sends a standard log message (non fatal) to the Crashlytics backend
- log(errorLevel, tag, msg) (Android only)
- setBool(key, value)
- setDouble(key, value)
- setFloat(key, value)
- setInt(key, value)
- setLong(key, value)
- setString(key, value)
- setUserEmail(email)
- setUserIdentifier(userId)
- setUserName(userName)
- crash(string)


### AngularJS integration (For use with Ionic framework)

Use the following snippet to integrate the plugin in your AngularJS app gracefully :

```js
var module = angular.module("my-module", []);

module.config(['$provide', function($provide) {
  $provide.decorator("$exceptionHandler", ['$delegate', function($delegate) {
    return function(exception, cause) {
      $delegate(exception, cause);

      if(navigator.fabric) {
        // Here, I rely on stacktrace-js (http://www.stacktracejs.com/) to format
        // exception stacktraces before sending it to the native bridge

        var message = exception.toString();
        var stacktrace = $window.printStackTrace({e: exception});
        var errorMessage = "ERROR: " + message + ", stacktrace: " + stacktrace;

        navigator.fabric.crashlytics.logException(errorMessage);

        // You may also want to crash the app because of a JS error. This is because
        // logException on iOS does not cause a crash, and so the error is not
        // sent to Fabric.
        navigator.fabric.crashlytics.crash();
      }
    };
  }]);
}]);
```
