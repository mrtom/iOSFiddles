//
//  TapFilter.h
//  taptest
//
//  Created by Tom Elliott on 15/10/2012.
//  Copyright (c) 2012 Tom Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Basic filter object
@interface TapFilter : NSObject
{
    BOOL adaptive;
    double filterConstant;
    
	UIAccelerationValue lastX, lastY, lastZ;
	UIAccelerationValue x, y, z;
}

-(id)initWithSampleRate:(double)rate cutoffFrequency:(double)freq;

// Add a UIAcceleration to the filter.
-(void)addAcceleration:(UIAcceleration*)accel;

@property(nonatomic, readonly) UIAccelerationValue x;
@property(nonatomic, readonly) UIAccelerationValue y;
@property(nonatomic, readonly) UIAccelerationValue z;

@property(nonatomic, getter=isAdaptive) BOOL adaptive;
@property(nonatomic, readonly) NSString *name;

@end
