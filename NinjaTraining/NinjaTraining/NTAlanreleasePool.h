//
//  NTAlanreleasePool.h
//  NinjaTraining
//
//  Created by Tom Elliott on 08/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTAlanreleasePool : NSObject

+ (NTAlanreleasePool *)currentPool;

- (void)addObject:(NSObject *)object;
- (void)drain;

@end
