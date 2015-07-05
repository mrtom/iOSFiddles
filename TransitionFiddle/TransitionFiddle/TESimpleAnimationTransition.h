//
//  TESimpleAnimationTransition.h
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TETransition.h"

@interface TESimpleAnimationTransition : TETransition

- (void)performTransitionFromView:(UIView *)fromView toView:(UIView *)toView inContainerView:(UIView *)containerView withDuration:(NSTimeInterval)duration;

@end
