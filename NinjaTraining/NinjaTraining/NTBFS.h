//
//  NTBFS.h
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NTNode;

@interface NTBFS : NSObject

+ (NSArray *) searchFromNode:(NTNode *)rootNode;

@end
