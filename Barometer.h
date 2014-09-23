//
//  Barometer.h
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#define BarometerLocalPressure @"localPressure"
#define BarometerSeaLevelPressure @"seaLevelPressure"

@class Barometer;
@protocol BarometerDelegate <NSObject>
@required
-(void)pressureDataUnavailable:(NSError *)error;
@optional
-(void)localPressureReadingUpdated:(float)pressure;
-(void)seaLevelPressureReadingUpdated:(float)pressure;
@end
@interface Barometer : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CMAltimeter *altimeter;
    NSInteger elevation;
    float seaLevelPressure;
    float localPressureFloat;
}
@property (strong,nonatomic) id<BarometerDelegate> delegate;
@property (strong,nonatomic) NSNumber *enableSeaLevelPressure;
-(void)startUpdatingPressureData;
@end
