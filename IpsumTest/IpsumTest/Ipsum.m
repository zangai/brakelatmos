//
//  Ipsum.m
//  IpsumTest
//
//  Created by Patrick Decoster on 09-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "Ipsum.h"
#import "WebRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "TokenParser.h"


@implementation Ipsum {
    NSString * _privateKey;
    NSString * _host;
}

@synthesize token;


-(id)init:(NSString *)privateKey {
    _privateKey = [privateKey lowercaseString];
    _host = @"http://ipsum.groept.be";
    return self;
}

-(BOOL)isAuthenticated {
    return (token != nil);
}

-(void)authenticateWithUsername:(NSString *)username
                       Password:(NSString *)password {
    NSString * hash = [self sha1:[NSString stringWithFormat:@"/auth/%@", _privateKey]];
    NSString * uri = [NSString stringWithFormat:@"%@/auth/%@", _host, hash];
    
    NSLog(@"Ipsum Request URI: %@", uri);
    
    NSString * postData = [NSString stringWithFormat:@"<UserLogin><username>%@</username><password>%@</password></UserLogin>", username, password];
    
    NSLog(@"Ipsum Request Body: %@", postData);
    
    [[WebRequest alloc] doPost:uri
                          data:postData
                      delegate:self
                      handleBy:@selector(loginCallHandler:response:)
    ];
    token = nil;
}

-(void)loginCallHandler:(id)caller
          response:(NSData *) response
{
    NSString *rData = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"Ipsum Response Body: %@", rData);

    NSData* data = [rData dataUsingEncoding:NSUTF8StringEncoding];
    
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    TokenParser* parser = [[TokenParser alloc] initXMLParser];
    [nsXmlParser setDelegate:parser];
    BOOL success = [nsXmlParser parse];
    
    // test the result
    if (success) {
        token = parser.token;
    } else {
        NSLog(@"Error parsing document!");
        NSLog([NSString stringWithFormat:@"%@", [nsXmlParser parserError]]);
    }
}

-(void)getLocations:(WebRequestCallback)completion {
    self.callback = completion;
    NSString * hash = [self sha1:[NSString stringWithFormat:@"/select/%@/@%", token.key, _privateKey]];
    NSString * uri = [NSString stringWithFormat:@"%@/select/%@/%@", _host, token.key, hash];
    
    NSLog(@"Ipsum Request URI: %@", uri);
    
    NSString* selectClause = [NSString stringWithFormat:@"<field><name></name></field>"];
    NSString* whereClause = [NSString stringWithFormat:@""];
    
    NSString * postData = [NSString stringWithFormat:@"<get><start>2012-01-01T00:00:00</start><end>2999-12-31T23:59:59</end><select>%@</select>%@</get>", selectClause, whereClause];
    
    NSLog(@"Ipsum Request Body: %@", postData);
    
    [[WebRequest alloc] doPost:uri
                          data:postData
                      delegate:self
                      handleBy:@selector(proxyCallHandler:response:)
    ];
}

-(void)proxyCallHandler:(id)caller
               response:(NSData *) response
{
    NSString *rData = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
    NSLog(@"Ipsum Response Body: %@", rData);
    
    self.callback(rData);
}

-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
