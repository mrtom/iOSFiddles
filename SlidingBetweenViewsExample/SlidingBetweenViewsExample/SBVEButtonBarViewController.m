//
//  SBVEButtonBarViewController.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEButtonBarViewController.h"

#import "SBVEPopupViewController.h"

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


#pragma mark - IB Actions

- (IBAction)buttonSelected:(id)sender
{
  NSLog([NSString stringWithFormat:@"Button %ld down", (long)[sender tag]]);
  
  [(UIButton *)sender setBackgroundColor:[UIColor blueColor]];
  [self.view addSubview:_popup.view];
  [_popup setupLayoutConstraints];
}

- (IBAction)buttonDeselected:(id)sender
{
  NSLog([NSString stringWithFormat:@"Button %ld up", (long)[sender tag]]);

  [(UIButton *)sender setBackgroundColor:[UIColor grayColor]];
  [_popup.view removeFromSuperview];
}

#pragma mark - Handling Touches

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches began on the Button Bar VC");
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches moved on the Button Bar VC");
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches ended on the Button Bar VC");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self touchesEnded:touches withEvent:event];
}

@end
