//
//  WebRequest.m
//  IpsumTest
//
//  Created by Patrick Decoster on 12-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "WebRequest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WebRequest {
    NSMutableData *receivedData;
    NSMutableArray *trustedHosts;
    id _delegate;
    SEL _handleBy;
};

-(void)setup {
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groept.be", nil];
}

-(void)doPost:(NSString*)command
              data:(NSString*)parameters
          delegate:(id)delegate
          handleBy:(SEL)handler {
    
    [self setup];
    _delegate = delegate;
    _handleBy = handler;
    NSString *urlString = command;
    NSURL *aUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    //[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    
    if (connection) {
        receivedData = [NSMutableData data];
    } else {
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    if (_delegate && _handleBy && [_delegate respondsToSelector:_handleBy]) {
        (void) [_delegate performSelector:_handleBy
                               withObject:data];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
