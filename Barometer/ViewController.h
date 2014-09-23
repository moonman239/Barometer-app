//
//  ViewController.h
//  Barometer
//
//  Created by Montana Burr on 9/23/14.
//  Copyright (c) 2014 Montana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Barometer.h"

@interface ViewController : UIViewController <BarometerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *localPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *seaLevelPressureLabel;
@property (strong,nonatomic) Barometer *barometerObject;
@end

