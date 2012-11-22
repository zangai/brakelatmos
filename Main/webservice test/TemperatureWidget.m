//
//  TemperatureWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "TemperatureWidget.h"

@implementation TemperatureWidget

@synthesize drawArea;

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
    NSLog(@"temperature");
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // And draw with a blue fill color
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    
    CGContextAddRect(context, self.bounds);
    CGContextStrokePath(context);
    
    
    // Close the path
    CGContextClosePath(context);
    // Fill & stroke the path
    CGContextDrawPath(context, kCGPathFillStroke);
}
@end
