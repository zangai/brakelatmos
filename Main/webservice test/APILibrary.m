//
//  APILibrary.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "APILibrary.h"

@implementation APILibrary
{
    NSMutableData *receivedData;
    NSString *baseAPIUrl;
    NSMutableArray *trustedHosts;
    
}

-(id) init
{
    baseAPIUrl = @"https://145.48.128.101/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"145.48.128.101", @"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
}

-(void)makeApiCall:(NSString*)command formdata:(NSString*) parameters {
    NSLog([NSString stringWithFormat:@"API CALL - %@ - %@", command, parameters]);
    
    NSString *urlString = [baseAPIUrl stringByAppendingString:command];
    NSURL *aUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    
    if (connection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data] ;
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    
    //TODO: calback
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([trustedHosts containsObject:challenge.protectionSpace.host]) {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
                 forAuthenticationChallenge:challenge];
        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
