//
//  TEObjcioTransition.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 02/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TEObjcioTransition.h"

@implementation TEObjcioTransition

- (instancetype)init
{
  if (self = [super init]) {
    self.duration = 0.5;
  }
  return self;
}

- (void)performTransitionFromView:(UIView *)fromView toView:(UIView *)toView inContainerView:(UIView *)containerView withDuration:(NSTimeInterval)duration
{
  [containerView addSubview:toView];
  toView.alpha = 0;
  
  [UIView animateWithDuration:duration animations:^{
    fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    toView.alpha = 1;
  } completion:^(BOOL finished) {
    fromView.transform = CGAffineTransformIdentity;
    [self.delegate pushTransition:self didFinish:finished];
  }];
}

@end
