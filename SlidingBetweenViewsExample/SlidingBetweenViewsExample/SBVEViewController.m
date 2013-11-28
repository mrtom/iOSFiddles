//
//  SBVEViewController.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEViewController.h"

#import "SBVEButtonBarViewController.h"

@interface SBVEViewController ()

@property SBVEButtonBarViewController *buttonBarVC;

@end

@implementation SBVEViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.buttonBarVC = [[SBVEButtonBarViewController alloc] init];
  [self.view addSubview:_buttonBarVC.view];
  [_buttonBarVC setupLayoutConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
