//
//  APILibrary.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APILibrary : NSObject

-(void)makeApiCall:(NSString*)command formdata:(NSString*) parameters;
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace;
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

@end
