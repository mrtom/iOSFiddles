//
//  TETransition.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "TETransition.h"

@implementation TETransition

- (instancetype)init
{
  if (self = [super init]) {
    _transitionType = TETransitionTypePush;
  }
  return self;
}

@end
