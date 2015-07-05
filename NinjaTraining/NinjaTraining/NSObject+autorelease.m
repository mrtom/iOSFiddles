//
//  NSObject+autorelease.m
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NSObject+autorelease.h"

#import "NTAutoreleasePoolFactory.h"
#import "NTAutoreleasePool.h"

@implementation NSObject (Autorelease)

- (NSObject *)autorelease
{
  NTAutoreleasePool *currentPool = [[NTAutoreleasePoolFactory sharedFactory] getPool];
  [currentPool addObject:self];
  
  return self;
}

@end
