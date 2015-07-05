//
//  NTCollectionsExperiments.m
//  NinjaTraining
//
//  Created by Tom Elliott on 17/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTCollectionsExperiments.h"

@implementation NTCollectionsExperiments

- (void)run
{
  NSString *one = @"one";
  NSString *two = @"two";
  NSString *three = @"three";
  
  NSSet *setOne = [NSSet setWithObjects:one, two, three, nil];
  NSDictionary *dictOne = [NSDictionary dictionaryWithObjectsAndKeys:one, @"one", two, @"two", three, @"three", nil];
  NSArray *arrayOne = [NSArray arrayWithObjects:one, two, three, nil];
  
  
  NSString *aString = [setOne anyObject];
  
  for (NSString *aString in setOne) {
    NSLog(@"%@", aString);
  }
  
  for (NSString *aString in [setOne objectEnumerator]) {
    NSLog(@"%@", aString);
  }
  
  for (NSString *aKeyString in [dictOne keyEnumerator]) {
    NSLog(@"%@", [dictOne objectForKey:aKeyString]);
  }
  
  for (NSString *aString in arrayOne) {
    NSLog(@"%@", aString);
  }
  
  for (NSString *aString in [arrayOne reverseObjectEnumerator]) {
    NSLog(@"%@", aString);
  }
  
  NSMutableSet *setTwo = [NSMutableSet new];
  [setTwo addObject:one];
  [setTwo removeObject:one];
  [setTwo containsObject:one];
  
  NSMutableDictionary *dictTwo = [NSMutableDictionary new];
  [dictTwo setObject:one forKey:@"one"];
  [dictTwo removeObjectForKey:@"one"];
  [dictTwo objectForKey:@"one"];
  
  NSMutableArray *arrayTwo = [NSMutableArray new];
  [arrayTwo addObject:one];
  [arrayTwo insertObject:two atIndex:0];
  [arrayTwo firstObject];
  [arrayTwo lastObject];
  [arrayTwo containsObject:one];
  [arrayTwo objectAtIndex:1];
  
}

@end
