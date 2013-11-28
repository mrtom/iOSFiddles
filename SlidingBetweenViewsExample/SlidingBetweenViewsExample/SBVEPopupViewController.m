//
//  SBVEPopupViewController.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEPopupViewController.h"

#import "SBVEPopupView.h"

@interface SBVEPopupViewController () {
  NSLayoutConstraint *movableViewX;
  NSLayoutConstraint *movableViewY;
}

@property UIView *movableView;

@end

@implementation SBVEPopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)loadView
{
  self.view = [[SBVEPopupView alloc] init];
  [(SBVEPopupView *)self.view setMyVC:self];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.view setBackgroundColor:[UIColor blueColor]];

  _movableView = [[UIView alloc] init];
  [_movableView setBackgroundColor:[UIColor redColor]];
  [_movableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.view addSubview:_movableView];
  
  NSDictionary *viewsDict = [NSDictionary dictionaryWithObjectsAndKeys:_movableView, @"movableView", self.view, @"view", nil];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[movableView(50)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDict]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[movableView(50)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDict]];
  
  movableViewX = [NSLayoutConstraint constraintWithItem:_movableView
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.0f
                                               constant:0.0f];
  [self.view addConstraint:movableViewX];
  
  movableViewY = [NSLayoutConstraint constraintWithItem:_movableView
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0f
                                               constant:0.0f];
  [self.view addConstraint:movableViewY];
}

- (void)setupLayoutConstraints
{
  [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  NSDictionary *viewsDict = [NSDictionary dictionaryWithObjectsAndKeys:self.view, @"popupView", nil];
  [self.view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[popupView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDict]];
  [self.view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[popupView(200)]-(40)-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDict]];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
  CGPoint pt = [[touches anyObject] locationInView: self.view];
  _movableView.center = CGPointMake(pt.x, pt.y);
}


@end
