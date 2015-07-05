//
//  NTNode.h
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTNode : NSObject

@property (nonatomic, strong) NSString *nodeLabel;
@property (nonatomic, strong) NSArray *children;

@end
