//
//  Alarm.m
//  BrakelApp
//
//  Created by wlmligte on 11/22/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}



- (void)drawTheRed:(UIView*)view
{
    UIView *rectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    rectangle.backgroundColor = [UIColor redColor];
    rectangle.alpha=0.5;
    [view addSubview:rectangle];
}


@end
