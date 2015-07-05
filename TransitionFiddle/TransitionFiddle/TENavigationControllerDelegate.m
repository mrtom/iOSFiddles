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
  return;
  
  // 0. Get Gesture information
  // Location reference
  UIWindow *window = [self.navController.view window];
  CGPoint location = [recognizer locationInView:window];
  // Velocity reference
  CGPoint velocity = [recognizer velocityInView:window];
  
  // 1. Gesture is started, show the modal controller
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    self.shouldPerformInteractiveTransition = YES;
    
    [self.rootViewController.navigationController popViewControllerAnimated:YES];
    
    if (location.x < CGRectGetMidX(recognizer.view.bounds)) {
      NSLog(@"First section");
      
      // Check that the modal controller view isn't currently shown
      // if(!self.modalController){
      
      // Instantiate the modal controller
      // self.modalController = [[ModalViewController alloc]init];
      // self.modalController.transitioningDelegate = self;
      // self.modalController.modalPresentationStyle = UIModalPresentationCustom;
      
      // Here we could set the mainController as delegate of the modal controller to get/set useful information
      // Example: self.modalController.delegate = self.mainController;
      
      // Present the controller
      // [self.mainController presentViewController:self.modalController animated:YES completion:nil];
      // }
    } else {
      NSLog(@"Second section");
      // With this implementation we want to dismiss the controller without the interactive transition, anyway, this would be a good place
      // to add code to dismiss it using an interactive transition
      // [self.modalController dismissViewControllerAnimated:YES completion:nil];
    }
  }
  
  
  
  // 2. Update the animation state
  else if (recognizer.state == UIGestureRecognizerStateChanged) {
    // self.finger.center = location;
    
    // Get the ratio of the animation depending on the touch location.
    // When location is at the left of the screen the animation is at its initial phase.
    // Moving to the right, the animation proceed, while moving to the right it is reverse played
    CGFloat animationRatio = location.x / CGRectGetWidth(window.bounds);
    NSLog(@"Ratio is: %f", animationRatio);
    [_currentInteractiveTransitioningDelegate updateInteractiveTransition:animationRatio];
  }
  
  
  
  // 3. Complete or cancel the animation when gesture ends
  else if (recognizer.state == UIGestureRecognizerStateEnded) {
    if (velocity.x > 0) {
      [_currentInteractiveTransitioningDelegate finishInteractiveTransition];
    } else {
      [_currentInteractiveTransitioningDelegate cancelInteractiveTransition];
    }
    
    self.shouldPerformInteractiveTransition = NO;
    _currentInteractiveTransitioningDelegate = nil;
  }
}

@end
