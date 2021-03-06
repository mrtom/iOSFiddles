//
//  NTDFS.h
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NTNode;

@interface NTDFS : NSObject

+ (void) searchFromNode:(NTNode *)rootNode withKnownNodes:(NSMutableArray *)knownNodes;

@end
