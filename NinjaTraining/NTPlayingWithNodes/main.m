//
//  main.m
//  NTPlayingWithNodes
//
//  Created by Tom Elliott on 16/12/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NTNode.h"
#import "NTBFS.h"
#import "NTDFS.h"
#import "NTCollectionsExperiments.h"

#import "NTBoggleWordGenerator.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
  
    NTNode *nodeA = [NTNode new];
    NTNode *nodeB = [NTNode new];
    NTNode *nodeC = [NTNode new];
    NTNode *nodeD = [NTNode new];
    NTNode *nodeE = [NTNode new];
    NTNode *nodeF = [NTNode new];
    NTNode *nodeG = [NTNode new];
    
    nodeA.nodeLabel = @"A";
    nodeB.nodeLabel = @"B";
    nodeC.nodeLabel = @"C";
    nodeD.nodeLabel = @"D";
    nodeE.nodeLabel = @"E";
    nodeF.nodeLabel = @"F";
    nodeG.nodeLabel = @"G";
    
    nodeA.children = [NSArray arrayWithObjects:nodeB, nodeC, nil];
    nodeB.children = [NSArray arrayWithObjects:nodeD, nodeE, nil];
    nodeC.children = [NSArray arrayWithObjects:nodeF, nodeG, nil];
    nodeD.children = [NSArray arrayWithObjects:nil];
    nodeE.children = [NSArray arrayWithObjects:nil];
    nodeF.children = [NSArray arrayWithObjects:nil];
    nodeG.children = [NSArray arrayWithObjects:nil];
    

    
    
    
    NTNode *node1 = [NTNode new];
    NTNode *node2 = [NTNode new];
    NTNode *node3 = [NTNode new];
    NTNode *node4 = [NTNode new];
    NTNode *node5 = [NTNode new];
    NTNode *node6 = [NTNode new];
    
    node1.nodeLabel = @"1";
    node2.nodeLabel = @"2";
    node3.nodeLabel = @"3";
    node4.nodeLabel = @"4";
    node5.nodeLabel = @"5";
    node6.nodeLabel = @"6";
    
    node1.children = [NSArray arrayWithObjects:node2, node5, node6, nil];
    node2.children = [NSArray arrayWithObjects:node3, node5, nil];
    node3.children = [NSArray arrayWithObjects:nil];
    node4.children = [NSArray arrayWithObjects:node3, nil];
    node5.children = [NSArray arrayWithObjects:node4, nil];
    node6.children = [NSArray arrayWithObjects:nil];
    
    
    NSLog(@"Depth First Searching...");
    
    NSMutableArray *knownNodes = [[NSMutableArray alloc] init];
    [NTDFS searchFromNode:nodeA withKnownNodes:knownNodes];
    
    for (NTNode *node in knownNodes) {
      NSLog(@"%@", node.nodeLabel);
    }
    
    knownNodes = [[NSMutableArray alloc] init];
    [NTDFS searchFromNode:node1 withKnownNodes:knownNodes];
    
    for (NTNode *node in knownNodes) {
      NSLog(@"%@", node.nodeLabel);
    }
    
    
    NSLog(@"Bredth first searching...");
    
    NSArray *output = [NTBFS searchFromNode:nodeA];
    for (NTNode *node in output) {
      NSLog(@"%@", node.nodeLabel);
    }
    
    output = [NTBFS searchFromNode:node1];
    for (NTNode *node in output) {
      NSLog(@"%@", node.nodeLabel);
    }
    
    NSLog(@"Boogle finder");
    NSArray *firstColumn = @[@"f", @"x", @"y", @"r"];
    NSArray *secondColumn = @[@"x", @"a", @"c", @"z"];
    NSArray *thirdColumn = @[@"p", @"x", @"e", @"g"];
    NSArray *fourthColumn = @[@"o", @"q", @"k", @"w"];
    
    NSArray *board = [NSArray arrayWithObjects:firstColumn, secondColumn, thirdColumn, fourthColumn, nil];
    
    NSArray *wordTests = @[@"face", @"zaseras", @"pop", @"fxyrzeaxpoqkw"];
    for (NSString *word in wordTests) {
      BOOL didFind = [NTBoggleWordGenerator findWord:word withBoard:board atXPosition:-1 yPosition:-1];
      if (didFind) NSLog(@"Found '%@'", word);
      else NSLog(@"Did not find '%@'", word);
    }
    
    // Collections
    NTCollectionsExperiments *collections = [NTCollectionsExperiments new];
    [collections run];
    
    
  }
  return 0;
}

