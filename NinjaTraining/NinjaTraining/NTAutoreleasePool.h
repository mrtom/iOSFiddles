//
//  NTAutorelease.h
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

/*
 
 * We need to have a stack of autorelease pools
 * We need each object to be able to be placed in the autorelease pool any number of times, so we need a counter
 * Thus each pool should be a dictionary, using the object as a key and a boxed NSUInteger as the value
 * When we drain the pool we should release each object until the count returns to 0
 * Threading: Each thread needs it's own autorelease pool
 
 * Data structures: We need, for each thread, a stack of autorelease pools. We drain the autorelease pool once the code moves past it's scope
 * You call [someObject autorelease] -> So we need to create an extension to NSObject that grabs the top of the stack for the current threads autorelease pools and
 * and or increments the key associated with someObject
 
 */

#import <Foundation/Foundation.h>

@interface NTAutoreleasePool : NSObject

- (BOOL)addObject:(NSObject *) object;
- (void)drain;

@end
