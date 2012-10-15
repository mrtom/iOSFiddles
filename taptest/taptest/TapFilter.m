//
//  TapFilter.m
//  taptest
//
//  Created by Tom Elliott on 15/10/2012.
//  Copyright (c) 2012 Tom Elliott. All rights reserved.
//

#import "TapFilter.h"

@implementation TapFilter

#define kAccelerometerMinStep				0.02
#define kAccelerometerNoiseAttenuation		3.0

@synthesize x, y, z, adaptive;

-(id)initWithSampleRate:(double)rate cutoffFrequency:(double)freq
{
	self = [super init];
	if(self != nil)
	{
		double dt = 1.0 / rate;
		double RC = 1.0 / freq;
		filterConstant = RC / (dt + RC);
	}
	return self;
}

-(void)addAcceleration:(UIAcceleration*)accel
{
	double alpha = filterConstant;
	
	if(adaptive)
	{
		double d = Clamp(fabs(Norm(x, y, z) - Norm(accel.x, accel.y, accel.z)) / kAccelerometerMinStep - 1.0, 0.0, 1.0);
		alpha = d * filterConstant / kAccelerometerNoiseAttenuation + (1.0 - d) * filterConstant;
	}
	
	x = alpha * (x + accel.x - lastX);
	y = alpha * (y + accel.y - lastY);
	z = alpha * (z + accel.z - lastZ);
	
	lastX = accel.x;
	lastY = accel.y;
	lastZ = accel.z;
}

-(NSString*)name
{
	return adaptive ? @"Adaptive Highpass Filter" : @"Highpass Filter";
}

double Norm(double x, double y, double z)
{
	return sqrt(x * x + y * y + z * z);
}

double Clamp(double v, double min, double max)
{
	if(v > max)
		return max;
	else if(v < min)
		return min;
	else
		return v;
}

@end