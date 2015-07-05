//
//  TETransitioningDelegate.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TETransitioningDelegate.h"
#import "TESimpleAnimationTransition.h"

@interface TETransitioningDelegate() {
  id<UIViewControllerContextTransitioning> _currentTransitioningContext;
}

@end

@implementation TETransitioningDelegate

- (instancetype)init
{
  return [self initWithRootViewController:nil transition:nil];
}

- (id)initWithRootViewController:(UIViewController *)viewController transition:(TETransition *)transition
{
  self = [super init];
  if (self) {
    _rootViewController = viewController;
    _transition = transition;
    _transition.delegate = self;
  }
  return self;
}

#pragma mark - Private instance methods

- (void)_completeTransition {
  UIView * containerView = _currentTransitioningContext.containerView;
  CATransform3D sublayerTransform = CATransform3DIdentity;
  containerView.layer.sublayerTransform = sublayerTransform;
  
  [_currentTransitioningContext completeTransition:YES];
  _currentTransitioningContext = nil;
}

- (void)_transitionInContainerView:(UIView *)containerView fromView:(UIView *)fromView toView:(UIView *)toView withTransition:(TETransition *)transition {
  
  if ([transition isKindOfClass:[TESimpleAnimationTransition class]]) {
    TESimpleAnimationTransition *simpleAnimationTransition = (TESimpleAnimationTransition *)transition;
    [simpleAnimationTransition performTransitionFromView:fromView toView:toView inContainerView:containerView withDuration:[self transitionDuration:_currentTransitioningContext]];
  }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return self;
}

- (nullable id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
  return self;
}

- (nullable id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(nonnull id<UIViewControllerAnimatedTransitioning>)animator
{
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return self.transition.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  _currentTransitioningContext = transitionContext;
  
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView * containerView = transitionContext.containerView;
  UIView * fromView = fromViewController.view;
  UIView * toView = toViewController.view;
  
  UIView * wrapperView = [[UIView alloc] initWithFrame:fromView.frame];
//  fromView.frame = fromView.bounds;
//  toView.frame = toView.bounds;
  wrapperView.frame = fromView.frame;
  toView.frame = fromView.frame;
  
  
  wrapperView.autoresizesSubviews = YES;
  wrapperView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [wrapperView addSubview:fromView];
  [wrapperView addSubview:toView];
  [containerView addSubview:wrapperView];
  

  _transition.delegate = self;
  [self _transitionInContainerView:wrapperView fromView:fromView toView:toView withTransition:_transition];
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
  _currentTransitioningContext = transitionContext;
  
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView * containerView = transitionContext.containerView;
  UIView * fromView = fromViewController.view;
  UIView * toView = toViewController.view;
  
  // I think I need to add these views as properties so they can be referenced in the gesture handler below(?)
}

#pragma mark - UIViewControllerAnimatedTransitioning

#pragma mark - UIPercentDrivenInteractiveTransition methods

- (CGFloat)duration
{
  return _transition.duration;
}

#pragma mark - TETransitionDelegate

- (void)pushTransitionDidFinish:(TETransition *)transition {
  [self _completeTransition];
}

- (void)popTransitionDidFinish:(TETransition *)transition {
  [self _completeTransition];
}

@end
