//
//  SBVEPopupView.h
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 28/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBVEBarButtonItem;
@class SBVEPopupViewController;

@interface SBVEPopupView : UIView

@property (nonatomic, weak) SBVEBarButtonItem *activeBarButtonItem;
@property (nonatomic, weak) SBVEPopupViewController *myVC;

@end
