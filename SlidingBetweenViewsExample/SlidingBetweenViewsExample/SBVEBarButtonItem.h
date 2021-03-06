//
//  SBVEBarButtonItem.h
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 28/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SBVEBarButtonItemDelegate.h"

#import "SBVEPopupViewController.h"

@interface SBVEBarButtonItem : UIView

@property (nonatomic, strong) id<SBVEBarButtonItemDelegate> delegate;
@property (nonatomic, strong) SBVEPopupViewController *popupVC;

- (void)showPopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event;
- (void)hidePopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event;

@end
