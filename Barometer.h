//
//  Barometer.h
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "AirPressureValue.h"
#define BarometerLocalPressure @"localPressure"
#define BarometerSeaLevelPressure @"seaLevelPressure"
@class Barometer;
@protocol BarometerDelegate <NSObject>
@required
-(void)dataUpdated:(AirPressureValue *)data;
-(void)pressureDataUnavailable:(NSError *)error;
@end
@interface Barometer : NSObject
-(void)startUpdatingPressureData;
@property (strong,nonatomic) id<BarometerDelegate> delegate;
@end
