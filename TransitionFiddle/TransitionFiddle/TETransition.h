//
//  TETransition.h
//  TransitionFiddle
//
//  Created by Tom Elliott on 01/07/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TETransitionDelegate;

typedef NS_ENUM(NSUInteger, TETransitionType) {
    TETransitionTypeNull,
    TETransitionTypePush,
    TETransitionTypePop,
};

@interface TETransition : NSObject

@property (nonatomic, weak, readwrite) id<TETransitionDelegate> delegate;
@property (nonatomic, assign, readwrite) NSTimeInterval duration;
@property (nonatomic, assign, readwrite) TETransitionType transitionType;

@end

@protocol TETransitionDelegate
@optional
- (void)pushTransitionDidFinish:(TETransition *)transition;
- (void)popTransitionDidFinish:(TETransition *)transition;
@end