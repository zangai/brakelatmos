//
//  RoomsViewController.h
//  splitviewnormaal
//
//  Created by wlmligte on 11/9/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"
@interface RoomsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *deuiviewnav;
@property (strong, nonatomic) IBOutlet UIImageView *mainView;
@property (nonatomic, strong) Alarm* al;


@property (nonatomic) int buildingIdentifier;


@end
