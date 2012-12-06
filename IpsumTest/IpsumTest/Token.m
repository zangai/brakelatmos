//
//  Token.m
//  IpsumTest
//
//  Created by Patrick Decoster on 09-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "Token.h"

@implementation Token

@synthesize key, expire;

-(id) initWithXML:(NSString*)xmlData
{
    self.key = @"aapjes";
    self.expire = [[NSDate alloc]initWithTimeIntervalSinceNow:0];
    return self;
}

@end
