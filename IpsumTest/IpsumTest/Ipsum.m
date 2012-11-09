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
    return NO;
}

-(void)authenticateWithUsername:(NSString *)username Password:(NSString *)password {
    
    NSString * hash = [self sha1:[NSString stringWithFormat:@"/auth/%@", _privateKey]];
    NSString * uri = [NSString stringWithFormat:@"%@/auth/%@", _host, hash];
    
    NSLog(@"%@", uri);
    
    NSString * postData = [NSString stringWithFormat:@"<UserLogin><username>%@</username><password>%@</password></UserLogin>", username, password];
    
    NSLog(@"%@", postData);
    
    [[WebRequest alloc] doPost:uri
                          data:postData
                      delegate:self
                      handleBy:@selector(callHandler:response:)
    ];
    
    token = [[Token alloc]init];
    token.key = @"MOE touch 2";
    token.expire = [[NSDate alloc]initWithTimeIntervalSinceNow:0];
}

-(void)callHandler:(id)caller
          response:(NSData *) response {
    
    NSString *rData = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
    NSLog(@"%@", rData);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Response van Ipsum"
                                                    message:rData
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

-(void) parseXml:(NSData *)data {
    //NSXMLParser *nextParser = [[NSXMLParser alloc]initWithData:data];
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
