//
//  SBVEBarButtonItem.m
//  SlidingBetweenViewsExample
//
//  Created by Tom Elliott on 28/11/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "SBVEBarButtonItem.h"

@implementation SBVEBarButtonItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

# pragma mark - Public methods

- (void)showPopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event
{
  [self setBackgroundColor:[UIColor blueColor]];
  [_delegate showPopupWithTouches:touches forEvent:event];
}

- (void)hidePopupWithTouches:(NSSet *)touches forEvent:(UIEvent *)event
{
  [self setBackgroundColor:[UIColor grayColor]];
  [_delegate hidePopupWithTouches:touches forEvent:event];
}

#pragma mark - Handling Touches and Events

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  NSLog(@"Calling hit test within the Bar Button Item");
  
  if ([super hitTest:point withEvent:event]) {
    [_popupView setActiveBarButtonItem:self];
    return _popupView;
  }
  
  return nil;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches began on Bar Button Item");
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches moved on Bar Button Item");
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
  NSLog(@"Touches ended on Bar Button Item");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self touchesEnded:touches withEvent:event];
}

@end
