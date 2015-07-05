//
//  TETransitioningDelegate.h
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TETransition.h"

@interface TETransitioningDelegate : UIPercentDrivenInteractiveTransition  <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning, TETransitionDelegate>

@property (nonatomic, strong, readonly) UIViewController *rootViewController;
@property (nonatomic, strong) TETransition * transition;

- (id)initWithRootViewController:(UIViewController *)viewController transition:(TETransition *)transition;

@end
