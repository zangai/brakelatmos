//
//  AlarmTestView.m
//  BrakelApp
//
//  Created by Tjitte de Visscher on 11/23/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "AlarmTestView.h"


@implementation AlarmTestView

@synthesize al;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
       
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGColorRef redColor =
//    [UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1.0].CGColor;
//    CGContextSetFillColorWithColor(ctx, redColor);
//    CGContextSetStrokeColorWithColor(ctx, redColor);
//    CGContextSetFillColorWithColor(ctx,redColor);
//    CGContextFillRect(ctx, self.bounds);
//    CGContextAddRect(ctx, self.bounds);
     al = [[Alarm alloc]init];
     [al drawTheRed:self];
    NSLog([NSString stringWithFormat:@"Width alarmOverlay: %f dash", self.bounds.size.width]);
    
}


@end
