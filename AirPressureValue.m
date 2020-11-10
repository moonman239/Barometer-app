//
//  AirPressureValue.m
//  Barometer
//
//  Created by Montana Burr on 10/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import "AirPressureValue.h"

@implementation AirPressureValue
{
    float kiloPascalsFloat;
    float mmHg;
    float psi;
    float inHg;
}
-(id)initWithkiloPascals:(float)kiloPascals
{
    self = [super init];
    if (self) {
        kiloPascalsFloat = kiloPascals;
        mmHg = kiloPascalsFloat * 7.50061683;
        psi = kiloPascalsFloat * 0.145037738;
        inHg = kiloPascalsFloat * 0.295301;
    };
    return self;
}

-(float)kiloPascals
{
    return kiloPascalsFloat;
}

-(float)mmHg
{
    return mmHg;
}
-(float)psi
{
    return psi;
}
-(float)inHg
{
    return inHg;
}
-(AirPressureValue *)convertToSeaLevelFromAltitude:(float)altitude
{
    float seaLevelPressure = kiloPascalsFloat / powf(1 - (0.0000225577 * altitude), 5.25588);
    AirPressureValue *seaLevelValue = [[AirPressureValue alloc] initWithkiloPascals:seaLevelPressure];
    return seaLevelValue;
}
@end
