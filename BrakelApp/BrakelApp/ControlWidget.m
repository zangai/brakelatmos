//
//  ControlWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/29/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "ControlWidget.h"

@implementation ControlWidget

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Control widget is showing now");
    /*button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button.frame = CGRectMake((float)self.bounds.origin.x, (float)self.bounds.origin.y+(float)self.bounds.size.height, (float)self.bounds.size.width, 50.0);
    [button setTitle:@"Showing temperature" forState:UIControlStateNormal];
    CGColorRef redColor =
    [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, redColor);
    CGContextSetFillColorWithColor(context,redColor);
    CGContextFillRect(context, self.bounds);
    CGContextSetLineWidth(context, 5.0);
    CGContextAddRect(context, self.bounds);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    [self drawGrid:rect];
    [self addSubview:button];*/
}

@end
