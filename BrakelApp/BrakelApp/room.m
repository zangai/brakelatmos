//
//  Room.m
//  testestestest
//
//  Created by Luc Rosenbrand on 11/16/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Room.h"

@implementation Room
@synthesize rect;
@synthesize alarm;
@synthesize enabled;
@synthesize roomID;


-(id)initWithRect:(CGRect)_rect isEnabled:(bool)_enabled isAlarming:(bool)_alarming named:(NSString*)name
{
    if (self = [super init])
    {
        rect = _rect;
        enabled = _enabled;
        alarm = _alarming;
        roomID = name;
    }
    return self;
}

@end
