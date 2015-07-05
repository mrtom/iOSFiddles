//
//  NTBFS.m
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTBFS.h"

#import "NTNode.h"

@implementation NTBFS

+ (NSArray *) searchFromNode:(NTNode *)rootNode
{
  NSMutableArray *output = [NSMutableArray new];
  
  NSMutableArray *queue = [[NSMutableArray alloc] init];
  [queue addObject:rootNode];
  
  while ([queue count] > 0) {
    NTNode *node = [queue firstObject];
    [queue removeObjectAtIndex:0];
    
    if (![output containsObject:node]) {
      [output addObject:node];
    }
    
    for (NTNode *child in node.children) {
      [queue addObject:child];
    }
  }
  
  return output;
}

@end
