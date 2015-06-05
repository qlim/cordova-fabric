# co.flocode.cordova.fabric

This plugin provides a bridge between javascript error handling and [Fabric](https://www.crashlytics.com/) serverside
client API. It is based heavily on the initial work done by [smistry-toushay](https://github.com/smistry-toushay/cordova-crashlytics-plugin) and [4sh-projects](https://github.com/4sh-projects/cordova-crashlytics-plugin).

## Installation

    cordova plugin add https://github.com/4sh-projects/cordova-crashlytics-plugin --variable FABRIC_API_SECRET=<YOUR CRASHLYTICS API SECRET HERE> --variable FABRIC_API_KEY=<YOUR CRASHLYTICS API KEY HERE>


## Fabric

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


### Supported platforms

- Android
- iOS

### AngularJS integration

Use the following snippet to integrate the plugin in your AngularJS app gracefully :

    var module = angular.module("my-module", []);

    module.config(['$provide', function($provide) {
        $provide.decorator("$exceptionHandler", ['$delegate', function($delegate) {
            return function(exception, cause) {
                $delegate(exception, cause);

                // Decorating standard exception handling behaviour by sending exception to crashlytics plugin
                var message = exception.toString();
                // Here, I rely on stacktrace-js (http://www.stacktracejs.com/) to format exception stacktraces before
                // sending it to the native bridge
                var stacktrace = $window.printStackTrace({e: exception});
                navigator.fabric.crashlytics.logException("ERROR: "+message+", stacktrace: "+stacktrace);
            };
        }]);
    }]);
