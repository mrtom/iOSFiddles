//
//  SBVEButtonBarViewController.h
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 27/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SBVEBarButtonItemDelegate.h"

@class SBVEBarButtonItem;

@interface SBVEButtonBarViewController : UIViewController<SBVEBarButtonItemDelegate>

@property (strong, nonatomic) IBOutlet SBVEBarButtonItem *button1;
@property (strong, nonatomic) IBOutlet SBVEBarButtonItem *button2;

- (void)setupLayoutConstraints;

@end
