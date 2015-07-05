//
//  TECistyMapperTransition.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 03/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TECityMapperTransition.h"

@implementation TECityMapperTransition

- (instancetype)init
{
  if (self = [super init]) {
    self.duration = 0.5;
  }
  return self;
}

- (void)performTransitionFromView:(UIView *)fromView toView:(UIView *)toView inContainerView:(UIView *)containerView withDuration:(NSTimeInterval)duration
{
  switch (self.transitionType) {
    case TETransitionTypePush:
      [self _performPushTransitionFromView:fromView toView:toView inContainerView:containerView withDuration:duration];
      break;
      
    default:
      [self _performPopTransitionFromView:fromView toView:toView inContainerView:containerView withDuration:duration];
      break;
  }
}

- (void)_performPushTransitionFromView:(UIView *)fromView toView:(UIView *)toView inContainerView:(UIView *)containerView withDuration:(NSTimeInterval)duration
{
  // [containerView addSubview:toView];
  
  CGRect currentFrame = toView.frame;
  toView.frame = CGRectMake(currentFrame.origin.x + currentFrame.size.width, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
  
  [UIView animateWithDuration:duration animations:^{
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(15, 15);
    fromView.transform =  CGAffineTransformConcat(scaleTransform, moveTransform);
    fromView.alpha = 0.3;
    
    toView.frame = currentFrame;
  } completion:^(BOOL finished) {
    fromView.transform = CGAffineTransformIdentity;
    fromView.alpha = 1.0;
    [self.delegate pushTransitionDidFinish:self];
  }];
}

- (void)_performPopTransitionFromView:(UIView *)fromView toView:(UIView *)toView inContainerView:(UIView *)containerView withDuration:(NSTimeInterval)duration
{
//  [containerView addSubview:toView];
  
  CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
  CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(15, 15);
  toView.transform = CGAffineTransformConcat(scaleTransform, moveTransform);
  toView.alpha = 0.3;
  
  [fromView.superview bringSubviewToFront:fromView];
  
  CGRect currentFromFrame = fromView.frame;
  CGRect outOfWindowFrame = CGRectMake(CGRectGetMaxX(currentFromFrame), currentFromFrame.origin.y, currentFromFrame.size.width, currentFromFrame.size.height);
  
  [UIView animateWithDuration:duration animations:^{
    toView.transform = CGAffineTransformIdentity;
    toView.alpha = 1.0f;
    
    fromView.frame = outOfWindowFrame;
  } completion:^(BOOL finished) {
    fromView.frame = currentFromFrame;
    [self.delegate popTransitionDidFinish:self];
  }];
}

@end
