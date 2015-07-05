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

- (void)_completeTransitionFinished:(BOOL)finished {
  UIView * containerView = _currentTransitioningContext.containerView;
  CATransform3D sublayerTransform = CATransform3DIdentity;
  containerView.layer.sublayerTransform = sublayerTransform;
  
  [_currentTransitioningContext completeTransition:finished];
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
  
  toView.frame = fromView.frame;
  
 [containerView addSubview:fromView];
 [containerView addSubview:toView];

  _transition.delegate = self;
  [self _transitionInContainerView:containerView fromView:fromView toView:toView withTransition:_transition];
}

#pragma mark - UIPercentDrivenInteractiveTransition methods

- (CGFloat)duration
{
  return _transition.duration;
}

- (void)finishInteractiveTransition
{
  [super finishInteractiveTransition];
  [self _completeTransitionFinished:YES];
}

- (void)cancelInteractiveTransition
{
  [super cancelInteractiveTransition];
  [self _completeTransitionFinished:NO];
}

#pragma mark - TETransitionDelegate

- (void)pushTransition:(TETransition *)transition didFinish:(BOOL)finished
{
  [self _completeTransitionFinished:finished];
}

- (void)popTransition:(TETransition *)transition didFinish:(BOOL)finished
{
  [self _completeTransitionFinished:finished];
}

- (void)interactiveTransition:(TETransition *)transition didFinish:(BOOL)finished
{
  [self _completeTransitionFinished:finished];
}

@end
