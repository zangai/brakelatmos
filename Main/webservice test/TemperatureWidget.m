//
//  TemperatureWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "TemperatureWidget.h"

#define DIVIDER 7

@implementation TemperatureWidget

@synthesize button;
@synthesize context;

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    
    return self;
}
+(TemperatureWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[TemperatureWidget alloc] initWithJson:json];
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"temperature widget is showing now");
    button = [UIButton buttonWithType:UIButtonTypeInfoLight];    
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
    [self addSubview:button];
}


- (void)drawGrid:(CGRect)rect
{
    NSInteger prevPoint;
    //bepaal de grote van de cellen
    NSInteger divider = DIVIDER;
    NSInteger cellX = self.bounds.size.width/divider;
    NSInteger cellY = self.bounds.size.height/divider;
    CGContextBeginPath(context);
    CGFloat red[4] = {1.0f, 1.0f, 1.0f, 1.0f};
    CGContextSetStrokeColor(context, red);
  for(NSInteger i = 0; i < self.bounds.size.width/divider; i++)
   { 
      CGContextMoveToPoint(context, self.bounds.origin.x+50, self.bounds.origin.y+50);
       CGContextAddLineToPoint(context, i*cellX, i*cellY);
        CGContextStrokePath(context);
       CGContextStrokePath(context);
   }
    
    
    
}
@end
