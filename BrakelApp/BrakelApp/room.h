//
//  Room.h
//  testestestest
//
//  Created by Luc Rosenbrand on 11/16/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject
@property CGRect rect;
@property bool enabled;
@property bool alarm;
@property NSString *roomName;
@property NSInteger floorID;

-(id)initWithRect:(CGRect)_rect isEnabled:(bool)_enabled isAlarming:(bool)_alarming named:(NSString*)name belongsToFloor:(NSInteger)floorID;
@end