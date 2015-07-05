//
//  NTDFS.m
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTDFS.h"

#import "NTNode.h"

@implementation NTDFS

+ (void) searchFromNode:(NTNode *)rootNode withKnownNodes:(NSMutableArray *)knownNodes
{
  if ([knownNodes containsObject:rootNode]) return;
  
  [knownNodes addObject:rootNode];
  
  for (NTNode *node in rootNode.children) {
    [NTDFS searchFromNode:node withKnownNodes:knownNodes];
  }
}

@end
