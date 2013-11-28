//
//  SBVEBarButtonItemDelegate.h
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 28/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBVEBarButtonItemDelegate <NSObject>

- (void)showPopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event;
- (void)hidePopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event;

@end
