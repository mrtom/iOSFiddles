//
//  NTRandomStuff.m
//  NinjaTraining
//
//  Created by Tom Elliott on 07/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTRandomStuff.h"

@implementation NTRandomStuff

+ (UIView *)findNode:(UIView *)node inClone:(UIView *)clone
{
  NSMutableArray *path = [[NSMutableArray alloc] init];
  UIView *nodeInClone = clone;
  while (node.superview) {
    NSInteger index = [node.superview.subviews indexOfObject:node];
    NSNumber *boxedIndex = [NSNumber numberWithInteger:index];
    [path addObject:boxedIndex];
    node = node.superview;
  }
  
  while ([path count] > 0) {
    NSNumber *boxedIndex = [path lastObject];
    [path removeLastObject];
    
    nodeInClone = [nodeInClone.subviews objectAtIndex:[boxedIndex integerValue]];
  }
  
  return nodeInClone;
}

+ (BOOL)doesRange:(NSRange)r1 intersetWithRange:(NSRange)r2
{
  if (r1.length == 0 || r2.length == 0) return NO;
  if (r1.location == NSNotFound || r2.location == NSNotFound) return NO;
  
  return !(
    // don't intersect
    (r1.location + r1.length <= r2.location) || (r2.location + r2.length <= r1.location)
  );
}

@end
