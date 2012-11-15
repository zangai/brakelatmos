//
//  TemperatureWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "TemperatureWidget.h"

@implementation TemperatureWidget

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    return self;
}
+(TemperatureWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[TemperatureWidget alloc] initWithJson:json];
}

-(void) draw
{
    NSLog(@"temperature");
}
@end
