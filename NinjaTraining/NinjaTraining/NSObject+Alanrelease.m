//
//  NSObject+Alanrelease.m
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NSObject+Alanrelease.h"

#import "NTAlanreleasePool.h"

@implementation NSObject (Alanrelease)

- (id)autorelease
{
  NTAlanreleasePool *pool = [NTAlanreleasePool currentPool];
  [pool addObject:self];
  
  return self;
}

@end
