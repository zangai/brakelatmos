//
//  Changes.m
//  BrakelApp
//
//  Created by CHRISTIAAN Rakowski on 11/29/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "Changes.h"

@implementation Changes

-(NSString*) toJSONString
{
    return [NSString stringWithFormat:@"{ \"GroupID\":%d, \"ChangeValue\":%d, \"ChangeStatus\":null }", self.GroupID, self.ChangeValue];
}

@end
