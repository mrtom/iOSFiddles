//
//  SBVEPopupView.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 28/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEPopupView.h"

#import "SBVEBarButtonItem.h"

@implementation SBVEPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Handling Touches and Events

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  NSLog(@"Calling hit test within the Popup View");
  return [super hitTest:point withEvent:event];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches began on Popup View");
  
  [_activeBarButtonItem showPopupWithTouches:touches forEvent:event];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches moved on Popup View");
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches ended on Popup View");
  
  [_activeBarButtonItem hidePopupWithTouches:touches forEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self touchesEnded:touches withEvent:event];
}


@end
