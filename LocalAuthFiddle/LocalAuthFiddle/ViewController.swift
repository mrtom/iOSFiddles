//
//  ViewController.swift
//  LocalAuthFiddle
//
//  Created by Tom Elliott on 10/06/2014.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
                            
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    var context = LAContext()
    var error = NSError()
    
    if (context.canEvaluatePolicy(LAPolicyDeviceOwnerAuthenticationWithBiometrics, error: error)) {
      context.evaluatePolicy(LAPolicyDeviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("Login Plz!", nil), reply: ((Bool, NSError!) -> Void)?)
    }
    
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

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}

