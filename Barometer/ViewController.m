//
//  ViewController.m
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize barometerObject;
- (void)viewDidLoad {
    [super viewDidLoad];
    barometerObject = [[Barometer alloc] init];
    [barometerObject setDelegate:self];
    [barometerObject startUpdatingPressureData];
}

-(void)pressureDataUnavailable:(NSError *)error
{
    [[self localPressureLabel] setText:@"N/A"];
    [[self seaLevelPressureLabel] setText:@"N/A"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)localPressureReadingUpdated:(float)pressure
{
    NSString *pressureStr = [NSString stringWithFormat:@"%0.1f",pressure];
    [[self localPressureLabel] setText:pressureStr];
    
}
@end
