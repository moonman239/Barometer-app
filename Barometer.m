//
//  Barometer.m
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import "Barometer.h"


@implementation Barometer

-(void)startUpdatingPressureData
{
    if ([CMAltimeter isRelativeAltitudeAvailable])
    {
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [queue addOperationWithBlock:^(void) { NSLog(@"Updating altitude data."); } ];
        [altimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:^(CMAltitudeData *data, NSError *error) {
            NSLog(@"%@",@"Altitude update received.");
            [self performSelectorOnMainThread:@selector(dataUpdated:) withObject:data waitUntilDone:false];
        }];
        NSLog(@"%lu",(unsigned long)[queue operationCount]);
    if ([self enableSeaLevelPressure] == [NSNumber numberWithBool:true])
    {
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDelegate:self];
    NSLog(@"%@",@"Subscribing to location updates.");
    [locationManager startUpdatingLocation];
    }
    }
    else
    {
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Can't retrieve altimeter data",NSLocalizedDescriptionKey, nil];
        NSError *error = [[NSError alloc] initWithDomain:@"altitude" code:050 userInfo:errorInfo];
        [[self delegate] pressureDataUnavailable:error];
    }
}

-(void)dataUpdated:(CMAltitudeData *)data
{
    if ([[self delegate] respondsToSelector:@selector(localPressureReadingUpdated:)]) {
        localPressureFloat = [[data pressure] floatValue];
        [[self delegate] localPressureReadingUpdated:localPressureFloat];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", @"Location received.");
    CLLocation *lastLocation = [locations lastObject];
    if ([[lastLocation timestamp] timeIntervalSinceNow] < 15)
    {
        elevation = [lastLocation altitude];
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[self delegate] pressureDataUnavailable:error];
}

-(void)seaLevelPressureDataUpdated
{
    float seaLevelPressure = localPressureFloat / powf((1.00 - 2.25577/100000),5.25588);
    NSNumber *seaLevelPressureNumber = [NSNumber numberWithFloat:seaLevelPressure];
}

@end
