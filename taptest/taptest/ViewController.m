//
//  ViewController.m
//  taptest
//
//  Created by Tom Elliott on 07/10/2012.
//  Copyright (c) 2012 Tom Elliott. All rights reserved.
//

#import "ViewController.h"
#import "TapFilter.h"
#import "GraphView.h"

#define kUpdateFrequency	 60.0

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
@synthesize mute;
@synthesize filtered;
@synthesize unfiltered;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isMuted = NO;
    
    filter = [[TapFilter alloc] initWithSampleRate:kUpdateFrequency cutoffFrequency:5.0];
    filter.adaptive = YES;

    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.updateInterval = 1.0 / kUpdateFrequency;
    self.accelerometer.delegate = self;
    
    [unfiltered setIsAccessibilityElement:YES];
    [unfiltered setAccessibilityLabel:@"Unfiltered"];
    [filtered setIsAccessibilityElement:YES];
    [filtered setAccessibilityLabel:@"Filtered"];
    
}

-(void)viewDidUnload {
    [super viewDidUnload];
    self.mute = nil;
    self.unfiltered = nil;
    self.filtered = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark UIAccelerometer methods
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if (!isMuted) {
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
        
        [filter addAcceleration:acceleration];
		[unfiltered addX:acceleration.x y:acceleration.y z:acceleration.z];
		[filtered addX:filter.x y:filter.y z:filter.z];
    }
}

-(IBAction)toggleMute:(id)sender {
    if (isMuted) {
        isMuted = NO;
        mute.title = @"Mute"; // TODO: Localise
    } else {
        isMuted = YES;
        mute.title = @"Unmute"; // TODO: Localise
    }
}

@end
