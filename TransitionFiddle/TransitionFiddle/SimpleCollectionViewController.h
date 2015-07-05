//
//  SimpleCollectionViewController.h
//  TransitionFiddle
//
//  Created by Tom Elliott on 30/06/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCollectionViewController : UICollectionViewController

@property (nonatomic, strong, readonly) NSString *navigationTitle;
@property (nonatomic, assign, readwrite) BOOL isRootViewController;

@end
