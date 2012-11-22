//
//  Alarm.m
//  BrakelApp
//
//  Created by wlmligte on 11/22/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

@synthesize viewForOverlay;

- (id)initWithFrame:(CGRect)frame : (UIView*) viewa
{
    self = [super initWithFrame:frame];
    if (self) {
        viewForOverlay = viewa;
        // Initialization code
    }
    return self;
}

- (void)drawOverlay:(UIView*)overlayView
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorRef redColor =
    [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(ctx, redColor);
    CGContextSetStrokeColorWithColor(ctx, redColor);
    CGContextSetFillColorWithColor(ctx,redColor);
    CGContextFillRect(ctx, overlayView.bounds);
    CGContextAddRect(ctx, overlayView.bounds);
    [overlayView addSubview:self];
}

- (void)drawRect:(CGRect)rect
{
[self drawOverlay:viewForOverlay];
    // Drawing code
}


@end
