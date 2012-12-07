//
//  Token.h
//  IpsumTest
//
//  Created by Patrick Decoster on 09-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Token : NSObject
{
    NSString* key;
    NSDate* expire;
}

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSDate* expire;

@end
