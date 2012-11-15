//
//  Widget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Widget.h"
#import "TemperatureWidget.h"

@implementation Widget

@synthesize WidgetId, Title, Description, XCoordinate, YCoordinate;

-(id)initWithJson:(NSDictionary*)json
{
    XCoordinate = json[@"x"];
    YCoordinate = json[@"y"];
    return self;
}

+(Widget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    NSArray* widgetTypes = [[NSArray alloc] initWithObjects: @"temp", @"air", @"co2", @"change", nil];
    NSInteger index = [widgetTypes indexOfObject:type];
    switch (index) {
        case 0:
        {
            return [TemperatureWidget makeWidgetWithType:type jsonData:json];
            break;
        }
        default:
        {
            return [[Widget alloc] initWithJson:json];
            break;
        }
    }
}

-(void) draw
{
    //Doe fancy draw dingen?
}

@end
