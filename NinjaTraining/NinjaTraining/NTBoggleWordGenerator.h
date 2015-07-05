//
//  NTBoogleWordGenerator.h
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTBoggleWordGenerator : NSObject

+ (BOOL)findWord:(NSString *)word withBoard:(NSArray *)board atXPosition:(int)x yPosition:(int)y;

@end
