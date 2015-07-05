//
//  TENavigationControllerDelegate.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TENavigationControllerDelegate.h"

#import "TETransitioningDelegate.h"

@interface TENavigationControllerDelegate()

@property (nonatomic, strong, readonly) UIViewController *rootViewController;
@property (nonatomic, strong, readonly) UINavigationController *navController;

@property (nonatomic, strong, readwrite) TETransitioningDelegate *currentInteractiveTransitioningDelegate;

@property (nonatomic, assign, readwrite) BOOL shouldPerformInteractiveTransition;

@end

@implementation TENavigationControllerDelegate

- (instancetype)initWithRootViewController:(UIViewController *)viewController
{
  if (self = [super init]) {
    _rootViewController = viewController;
    _navController = _rootViewController.navigationController;
    _shouldPerformInteractiveTransition = NO;
    
    UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(_gestureHandler:)];
    panGesture.edges = UIRectEdgeLeft;
    
    [[[_navController view] window] addGestureRecognizer:panGesture];
  }
  return self;
}

#pragma mark - UINavigationControllerDelegate methods

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {

  id <UIViewControllerInteractiveTransitioning> interactionController = nil;
  
  if ([animationController respondsToSelector:@selector(startInteractiveTransition:)]) {
    if (self.shouldPerformInteractiveTransition) {
      interactionController = (id<UIViewControllerInteractiveTransitioning>)animationController;
      _currentInteractiveTransitioningDelegate = (TETransitioningDelegate *)interactionController;
    }
  }
  
  return interactionController;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
  switch (operation) {
    case UINavigationControllerOperationPush:
      if ([toVC.transitioningDelegate respondsToSelector:@selector(animationControllerForPresentedController:presentingController:sourceController:)]) {
        TETransitioningDelegate * delegate = (TETransitioningDelegate *)toVC.transitioningDelegate;
        delegate.transition.transitionType = TETransitionTypePush;
        return delegate;
      } else {
        return nil;
      }
    case UINavigationControllerOperationPop:
      if ([fromVC.transitioningDelegate respondsToSelector:@selector(animationControllerForDismissedController:)]){
        TETransitioningDelegate * delegate = (TETransitioningDelegate *)fromVC.transitioningDelegate;
        delegate.transition.transitionType = TETransitionTypePop;
        return delegate;
      } else {
        return nil;
      }
    default:
      return nil;
  }
}

#pragma mark - Private instance methods

- (void)_gestureHandler:(UIScreenEdgePanGestureRecognizer *)recognizer
{
  UIWindow *window = [self.navController.view window];
  CGPoint location = [recognizer locationInView:window];
  CGPoint velocity = [recognizer velocityInView:window];
  
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    
    self.shouldPerformInteractiveTransition = YES;
    [self.rootViewController.navigationController popViewControllerAnimated:YES];
  
  } else if (recognizer.state == UIGestureRecognizerStateChanged) {
  
    CGFloat animationRatio = location.x / CGRectGetWidth(window.bounds);
    [_currentInteractiveTransitioningDelegate updateInteractiveTransition:animationRatio];
  
  } else if (recognizer.state == UIGestureRecognizerStateEnded) {
  
    if (velocity.x > 0 && location.x > window.bounds.size.width / 3) {
      [_currentInteractiveTransitioningDelegate finishInteractiveTransition];
    } else {
      [_currentInteractiveTransitioningDelegate cancelInteractiveTransition];
    }
    
    self.shouldPerformInteractiveTransition = NO;
    _currentInteractiveTransitioningDelegate = nil;
  }
}

@end
