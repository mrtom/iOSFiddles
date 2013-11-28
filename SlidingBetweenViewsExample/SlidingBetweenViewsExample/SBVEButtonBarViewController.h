//
//  SBVEButtonBarViewController.h
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBVEButtonBarViewController : UIViewController

- (IBAction)buttonSelected:(id)sender;
- (IBAction)buttonDeselected:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;

- (void)setupLayoutConstraints;

@end
