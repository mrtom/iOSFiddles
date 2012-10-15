//
//  ViewController.h
//  taptest
//
//  Created by Tom Elliott on 07/10/2012.
//  Copyright (c) 2012 Tom Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TapFilter;
@class GraphView;

@interface ViewController : UIViewController <UIAccelerometerDelegate> {
    IBOutlet UILabel *labelX;
    IBOutlet UILabel *labelY;
    IBOutlet UILabel *labelZ;
    
    IBOutlet UIProgressView *progressX;
    IBOutlet UIProgressView *progressY;
    IBOutlet UIProgressView *progressZ;
    
    GraphView *unfiltered;
	GraphView *filtered;
    
    BOOL isMuted;
    
    UIAccelerometer *accelerometer;
    TapFilter *filter;    
}

@property (nonatomic, retain) IBOutlet UILabel *labelX;
@property (nonatomic, retain) IBOutlet UILabel *labelY;
@property (nonatomic, retain) IBOutlet UILabel *labelZ;

@property (nonatomic, retain) IBOutlet UIProgressView *progressX;
@property (nonatomic, retain) IBOutlet UIProgressView *progressY;
@property (nonatomic, retain) IBOutlet UIProgressView *progressZ;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *mute;
@property (nonatomic, retain) UIAccelerometer *accelerometer;

@property (nonatomic, retain) IBOutlet GraphView *unfiltered;
@property (nonatomic, retain) IBOutlet GraphView *filtered;

-(IBAction)toggleMute:(id)sender;

@end
