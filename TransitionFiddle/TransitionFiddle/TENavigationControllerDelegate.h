//
//  TENavigationControllerDelegate.h
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TENavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

- (instancetype)initWithRootViewController:(UIViewController *)viewController;

@end
