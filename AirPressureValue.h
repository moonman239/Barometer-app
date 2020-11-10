//
//  AirPressureValue.h
//  Barometer
//
//  Created by Montana Burr on 10/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirPressureValue : NSObject
-(id)initWithkiloPascals:(float)kiloPascals;
-(float)kiloPascals;
-(float)mmHg;
-(float)psi;
-(float)inHg;
-(AirPressureValue *)convertToSeaLevelFromAltitude:(float)altitude;
@end
