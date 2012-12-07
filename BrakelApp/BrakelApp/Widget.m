//
//  Widget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Widget.h"
#import "TemperatureWidget.h"
#import "ControlWidget.h"
#import "WindWidget.h"
#import "CO2Widget.h"

@implementation Widget

@synthesize WidgetId, Title, Description, XCoordinate, YCoordinate;

-(id)initWithJson:(NSDictionary*)json
{
    NSInteger x = ((NSString*)json[@"x"]).integerValue;
    NSInteger y = ((NSString*)json[@"y"]).integerValue;
    NSInteger w = ((NSString*)json[@"w"]).integerValue;
    NSInteger h = ((NSString*)json[@"h"]).integerValue;
    self = [super initWithFrame:CGRectMake(x,y,w,h)];
    XCoordinate = x;
    YCoordinate = y;
    self.backgroundColor = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0];
        return self;
}


+(Widget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    NSArray* widgetTypes = [[NSArray alloc] initWithObjects: @"temp", @"wind", @"co2", @"control", nil];
    NSInteger index = [widgetTypes indexOfObject:type];
    switch (index) {
        case 0:
        {
            return [TemperatureWidget makeWidgetWithType:type jsonData:json];
            break;
        }
        case 1:
        {
            return [WindWidget makeWidgetWithType:type jsonData:json];
            break;
        }
        case 2:
        {
            return [CO2Widget makeWidgetWithType:type jsonData:json];
            break;
        }
            
        case 3:
        {
            return [ControlWidget makeWidgetWithType:type jsonData:json];
            break;
        }
        default:
        {
            return [[Widget alloc] initWithJson:json];
            break;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Normal Base Widget");
}

@end
