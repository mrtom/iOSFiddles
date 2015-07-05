// Playground - noun: a place where people can play

import UIKit
import LocalAuthentication

var str = "Hello, playground"

var name = "Blah blah"

LAContext *context = [[LAContext alloc] init];
NSError *error = nil;

if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
  error:&error])
{
  [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
    localizedReason:NSLocalizedString(@"...", nil)
    reply:^(BOOL success, NSError *error) {
    if (success) {
    // ...
    } else {
    NSLog(@"%@", error);
    }
    }];
} else {
  NSLog(@"%@", error);
}
