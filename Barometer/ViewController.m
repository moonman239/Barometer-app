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
{
    CLLocationManager *locationManager;
    NSMutableDictionary *pressureData;
    float altitude;
}
@synthesize barometerObject;
- (void)viewDidLoad {
    [super viewDidLoad];
    altitude = -1;
    barometerObject = [[Barometer alloc] init];
    [barometerObject setDelegate:self];
    [barometerObject startUpdatingPressureData];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    pressureData = [[NSMutableDictionary alloc] init];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

-(void)pressureDataUnavailable:(NSError *)error
{
    [[self localPressureLabel] setText:@"N/A"];
    [[self seaLevelPressureLabel] setText:@"N/A"];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    if ([location altitude]) {
        altitude = [location altitude];
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(void)dataUpdated:(AirPressureValue *)data
{
    float inHg = [data inHg];
    NSLog(@"%f",inHg);
    NSString *pressureString = [NSString stringWithFormat:@"%.02f inHg",inHg];
    [[self localPressureLabel] setText:pressureString];
    AirPressureValue *seaLevelPressureValue = [data convertToSeaLevelFromAltitude:altitude];
    if (altitude > -1)
    {
    NSString *seaLevelPressureString = [NSString stringWithFormat:@"%.01f inHg",[seaLevelPressureValue inHg]];
    [[self seaLevelPressureLabel] setText:seaLevelPressureString];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
