//
//  NTAutorelease.m
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTAutoreleasePool.h"

@interface NTAutoreleasePool()

@property NSMutableDictionary *objectsInPool;

@end

@implementation NTAutoreleasePool

- (id)init
{
  self = [super init];
  if (self) {
    _objectsInPool = [[NSMutableDictionary alloc] initWithCapacity:100];
  }
  return self;
}

- (BOOL)addObject:(NSObject *) object
{
  if ([_objectsInPool objectForKey:object]) {
    // Exists, increment
    NSNumber *count = [_objectsInPool objectForKey:object];
    NSInteger newCount = [count integerValue] + 1;
    [_objectsInPool setObject:[NSNumber numberWithInteger:newCount] forKey:object];
  } else {
    [_objectsInPool setObject:[NSNumber numberWithInteger:0] forKey:object];
  }
  
  return NO;
}

- (void)drain
{
  NSEnumerator *kE = [_objectsInPool keyEnumerator];
  NSObject *object;
  
  while((object = [kE nextObject])) {
    NSNumber *count = [_objectsInPool objectForKey:object];
    NSInteger countInt = [count integerValue];
    
    for (int i = countInt; i > 0; i++) {
      [object release];
    }
  }
  
  [_objectsInPool removeAllObjects];
}

@end
