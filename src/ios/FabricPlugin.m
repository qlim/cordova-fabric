#import <Crashlytics/Crashlytics.h>

#import "FabricPlugin.h"

@interface FabricPlugin ()

@end

@implementation FabricPlugin

#pragma mark - Initializers

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)logException:(CDVInvokedUrlCommand *)command {
    [self log:command];
}

- (void)log:(CDVInvokedUrlCommand *)command {
    CLS_LOG(@"%@", command.arguments[0]);

    [self resultOK:command];
}

- (void)setBool:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setBoolValue:((NSNumber*)command.arguments[1]).boolValue forKey:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setDouble:(CDVInvokedUrlCommand *)command {
    [self setFloat:command];
}

- (void)setFloat:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setFloatValue:((NSNumber*)command.arguments[1]).floatValue forKey:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setInt:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setIntValue:((NSNumber*)command.arguments[1]).intValue forKey:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setLong:(CDVInvokedUrlCommand *)command {
    [self setInt:command];
}

- (void)setString:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setObjectValue:(NSString *)command.arguments[1] forKey:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setUserEmail:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setUserEmail:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setUserIdentifier:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setUserIdentifier:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)setUserName:(CDVInvokedUrlCommand *)command {
    [CrashlyticsKit setUserName:(NSString *)command.arguments[0]];

    [self resultOK:command];
}

- (void)crash:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count == 0) {
        [[Crashlytics sharedInstance] crash];
    } else {
        [NSException raise:@"Simulated Crash" format:@"%@", command.arguments[0]];
    }

    [self resultOK:command];
}

- (void)resultOK:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* res = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

@end
