//
//  ViewController.m
//  taptest
//
//  Created by Tom Elliott on 07/10/2012.
//  Copyright (c) 2012 Tom Elliott. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize labelX;
@synthesize progressX;
@synthesize labelY;
@synthesize progressY;
@synthesize labelZ;
@synthesize progressZ;
@synthesize accelerometer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.updateInterval = .1;
    self.accelerometer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark UIAccelerometer methods
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if (acceleration.x > 0.005f) {
        labelX.text = [NSString stringWithFormat:@"%@%f", @"X: ", acceleration.x];
    }
    
    if (acceleration.y > 0.005f) {
        labelY.text = [NSString stringWithFormat:@"%@%f", @"Y: ", acceleration.y];
    }
    
    if (acceleration.z > 0.005f) {
        labelZ.text = [NSString stringWithFormat:@"%@%f", @"Z: ", acceleration.z];        
    }
    
    self.progressX.progress = ABS(acceleration.x);
    self.progressY.progress = ABS(acceleration.y);
    self.progressZ.progress = ABS(acceleration.z);
}

@end
