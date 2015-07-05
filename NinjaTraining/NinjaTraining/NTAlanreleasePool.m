//
//  NTAlanreleasePool.m
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTAlanreleasePool.h"

@interface NTAlanreleasePool()

@property NSMutableArray *pool;

@end

@implementation NTAlanreleasePool

+ (NSMutableArray *)poolsForCurrentThread
{
  NSDictionary *threadDict = [[NSThread currentThread] threadDictionary];
  NSString *autoReleasePoolString = @"autoReleasePoolThreadDictionaryString";
  NSMutableArray *pools = [threadDict objectForKey:autoReleasePoolString];
  if (!pools) {
    pools = [[NSMutableArray alloc] init];
    [threadDict setValue:pools forKey:autoReleasePoolString];
  }
  return pools;
}

+ (NTAlanreleasePool *)currentPool
{
  return [[self poolsForCurrentThread] lastObject];
}

// Lifecycle methods

- (id)init
{
  self = [super init];
  if (self) {
    _pool = [[NSMutableArray alloc] init];
    [[self poolsForCurrentThread] addObject:self];
  }
  return self;
}

- (void)dealloc
{
  [_pool release];
  [[self poolsForCurrentThread] removeObject:self];
  
  [super dealloc];
}

// Interface methods

- (void)addObject:(NSObject *)object
{
  [_pool addObject:object];
}

- (void)drain
{
  for (NSObject *object in _pool) {
    [object release];
  }
  
  [_pool removeAllObjects];
}



@end
