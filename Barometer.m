//
//  Barometer.m
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import "Barometer.h"


@implementation Barometer
{
    CMAltimeter *altimeter;
    NSInteger elevation;
}

-(id)init
{
    self = [super init];
    if (self) {
        altimeter = [[CMAltimeter alloc] init];
    }
    return self;
}


-(void)startUpdatingPressureData
{
    if ([CMAltimeter isRelativeAltitudeAvailable])
    {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        void(^altHandler)(CMAltitudeData *data, NSError *error) = ^(CMAltitudeData *data, NSError *error) {
            if (!error) {
                AirPressureValue *value = [[AirPressureValue alloc] initWithkiloPascals:[[data pressure] floatValue]];
                [(NSObject *)[self delegate] performSelectorOnMainThread:@selector(dataUpdated:) withObject:value waitUntilDone:true];
            }
            else
            {
                [(NSObject *)[self delegate] performSelectorOnMainThread:@selector(pressureDataUnavailable:) withObject:error waitUntilDone:true];
            }
        };
    [queue addOperationWithBlock:^(void) { NSLog(@"Updating altitude data."); } ];
        [altimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:altHandler];
    }
}

@end
