//
//  TokenParser.h
//  IpsumTest
//
//  Created by CHRISTIAAN Rakowski on 12/6/12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Token;

@interface TokenParser : NSObject <NSXMLParserDelegate>
{
    // an ad hoc string to hold element value
    NSMutableString* currentElementValue;
    // user object
    Token* token;
    NSString* tokenKey;
    NSDate* tokenExpire;
}

@property (nonatomic, retain) Token* token;

- (TokenParser*) initXMLParser;


@end