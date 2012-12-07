//
//  TokenParser.m
//  IpsumTest
//
//  Created by CHRISTIAAN Rakowski on 12/6/12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "TokenParser.h"
#import "Token.h"

@implementation TokenParser

@synthesize token;

- (TokenParser*) initXMLParser {
    self = [super init];
    return self;
}

- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"Credentials"]) {
        NSLog(@"Credentials element found – create a new instance of Token class...");
        token = [[Token alloc] init];
        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here:
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
    if ([elementName isEqualToString:@"token"]) {
        NSLog(@"token string found");
        tokenKey = [[NSString alloc] init];
    }
    if ([elementName isEqualToString:@"expire"]) {
        NSLog(@"expire date string found");
        tokenExpire = [[NSDate alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    }
    NSLog(@"Processing value for : %@", string);
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"Credentials"]) {
        
        token.expire = tokenExpire;
        return;
    }
    
    if ([elementName isEqualToString:@"token"]) {
        // We are done with token entry – add the parsed Token object
        token.key = tokenKey;
    }
    if ([elementName isEqualToString:@"expire"]) {
        // We are done with expire entry – add the parsed Token object
        token.expire = tokenExpire;
    } else {
        // The parser hit one of the element values.
        // This syntax is possible because User object
        // property names match the XML user element names
        [token setValue:currentElementValue forKey:elementName];
    }
}

@end
