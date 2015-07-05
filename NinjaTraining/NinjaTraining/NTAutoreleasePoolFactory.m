//
//  NTAutoreleasePoolFactory.m
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTAutoreleasePoolFactory.h"

#import "NTAutoreleasePool.h"

@interface NTAutoreleasePoolFactory()

@property (nonatomic, strong) NSMutableDictionary *poolsByThread;

@end

@implementation NTAutoreleasePoolFactory

+ (id)sharedFactory {
  static NTAutoreleasePoolFactory *sharedFactory = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedFactory = [[self alloc] init];
  });
  return sharedFactory;
}

- (id)init
{
  self = [super init];
  if (self) {
    _poolsByThread = [[NSMutableDictionary alloc] initWithCapacity:10];
  }
  return self;
}

- (void)pushPool
{
  NTAutoreleasePool *newPool = [[NTAutoreleasePool alloc] init];
  
  NSThread *currentThread = [NSThread currentThread];
  NSMutableArray *stack = [_poolsByThread objectForKey:currentThread];
  if (!stack) {
    stack = [[NSMutableArray alloc] init];
    [_poolsByThread setValue:stack forKey:currentThread];
  }
  
  [stack addObject:newPool];
}

- (NTAutoreleasePool *)popPool
{
  NSMutableArray *stack = [_poolsByThread objectForKey:[NSThread currentThread]];
  NTAutoreleasePool *pool = [stack lastObject];
  [stack removeLastObject];
  
  return pool;
}

- (NTAutoreleasePool *)getPool
{
  return [self _getOrPutPool];
}


// Gets the pool at the top of the stack for the current thread and pushes
// one there if it's empty
- (NTAutoreleasePool *)_getOrPutPool
{
  NSThread *currentThread = [NSThread currentThread];
  
  // How do you lock here?
  NSMutableArray *pools = [_poolsByThread objectForKey:currentThread];
  if (pools && [pools count] > 0) {
    return [pools lastObject];
  } else {
    if (!pools) {
      pools = [[NSMutableArray alloc] init];
      [_poolsByThread setValue:pools forKey:currentThread];
    }
    NTAutoreleasePool *pool = [[NTAutoreleasePool alloc] init];
    [pools insertObject:pool atIndex:0];
    return pool;
  }
}

@end
