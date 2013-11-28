//
//  BSViewController.h
//  BeaconScrach
//
//  Created by Tom Elliott on 26/09/2013.
//  Copyright (c) 2013 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CLLocationManagerDelegate.h>

@interface BSViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)searchForBeacons:(id)sender;


@end
