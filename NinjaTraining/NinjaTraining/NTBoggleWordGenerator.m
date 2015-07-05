//
//  NTBoogleWordGenerator.m
//  NinjaTraining
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import "NTBoggleWordGenerator.h"

@implementation NTBoggleWordGenerator

+ (BOOL)findWord:(NSString *)word withBoard:(NSArray *)board atXPosition:(int)x yPosition:(int)y
{
  if ([word isEqualToString:@""]) return YES;
  
  if (x == -1 || y == -1) {
    // Perform a linear scan to find possible locations for the first letter
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        NSString *firstLetter = [word substringToIndex:1];
        NSString *charAtLocation = [(NSArray *)[board objectAtIndex:i] objectAtIndex:j];
        if ([charAtLocation isEqualToString:firstLetter]) {
          NSMutableArray *newBoard = [NTBoggleWordGenerator copyBoard:board];
          [(NSMutableArray *)[newBoard objectAtIndex:i] removeObjectAtIndex:j];
          [(NSMutableArray *)[newBoard objectAtIndex:i] insertObject:@"?" atIndex:j];
          
          return [NTBoggleWordGenerator findWord:[word substringFromIndex:1] withBoard:newBoard atXPosition:i yPosition:j];
        }
      }
    }
  } else {
    // Recursively call yourself with substring
    NSString *nextLetter = [word substringToIndex:1];
    for (int i = MAX(0, x-1); i <= MIN(x+1, 3); i++) {
      for (int j = (MAX(0, y-1)); j <= MIN(y+1, 3); j++) {
        NSString *boardValue = [((NSArray *)[board objectAtIndex:i]) objectAtIndex:j];
        if ((i != x || j != y) && [nextLetter isEqualToString:boardValue]) {
          NSMutableArray *newBoard = [NTBoggleWordGenerator copyBoard:board];
          [(NSMutableArray *)[newBoard objectAtIndex:i] removeObjectAtIndex:j];
          [(NSMutableArray *)[newBoard objectAtIndex:i] insertObject:@"?" atIndex:j];
          
          NSString *subStr = [word substringFromIndex:1];
          return [NTBoggleWordGenerator findWord:subStr withBoard:newBoard atXPosition:i yPosition:j];
        }
      }
    }
  }
  
  return NO;
}

+ (NSMutableArray *)copyBoard:(NSArray *)board
{
  NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:4];
  
  for (NSArray *column in board) {
    NSMutableArray *newColumn = [[NSMutableArray alloc] initWithArray:column];
    [newArray addObject:newColumn];
  }
  
  return newArray;
}

@end
