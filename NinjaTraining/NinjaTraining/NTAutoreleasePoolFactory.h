//
//  NTAutoreleasePoolFactory.h
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NTAutoreleasePool;

@interface NTAutoreleasePoolFactory : NSObject

// For simplicity, let's make this a singleton
+ (id)sharedFactory;

- (void)pushPool;
- (NTAutoreleasePool *)popPool;
- (NTAutoreleasePool *)getPool; // Returns the same pool popPool would, but doesn't pop it off the stack

@end
