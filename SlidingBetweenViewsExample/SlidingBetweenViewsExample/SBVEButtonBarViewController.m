//
//  SBVEButtonBarViewController.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEButtonBarViewController.h"

#import "SBVEPopupViewController.h"
#import "SBVEBarButtonItem.h"

@interface SBVEButtonBarViewController ()

@property (nonatomic, strong) SBVEPopupViewController* popup;

@end

@implementation SBVEButtonBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  _popup = [[SBVEPopupViewController alloc] init];
  [_popup.view setAlpha:0.0f];
  [self.view addSubview:_popup.view];
  
  [_button1 setDelegate:self];
  [_button1 setPopupView:(SBVEPopupView *)_popup.view];
  
  [_button2 setDelegate:self];
  [_button2 setPopupView:(SBVEPopupView *)_popup.view];
}

- (void)setupLayoutConstraints
{
  NSDictionary *viewsDict = [NSDictionary dictionaryWithObject:self.view forKey:@"buttonBarView"];
  [self.view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buttonBarView]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDict]];
  [self.view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[buttonBarView(50)]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDict]];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Handling Touches

- (void)showPopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event
{
  // FIXME (tomelliott) Adding the popup to the view here breaks touches being sent to the popup view :/
  [_popup.view setAlpha:1.0f];
  [_popup setupLayoutConstraints];
}

- (void)hidePopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event
{
  [_popup.view setAlpha:0.0f];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self touchesEnded:touches withEvent:event];
}

@end
