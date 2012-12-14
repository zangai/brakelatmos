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

    NSRange range;
    token = [[Token alloc] init];
    
    NSRange startrange = [rData rangeOfString: @"<token>"];
    NSRange endrange = [rData rangeOfString: @"</token>"];
    range.location = (startrange.location + startrange.length);
    range.length = (endrange.location - range.location);
    
    NSString* tokenString = [rData substringWithRange:range];
    token.key = tokenString;
    
    startrange = [rData rangeOfString: @"<expire>"];
    endrange = [rData rangeOfString: @"</expire>"];
    range.location = (startrange.location + startrange.length);
    range.length = (endrange.location - range.location);
    
    tokenString = [rData substringWithRange:range];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    //2012-12-07T10:22:36
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    token.expire = [dateFormatter dateFromString:tokenString];
    
    /*
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
     */
}

-(void)getLocations:(WebRequestCallback)completion {
    self.callback = completion;
    
    int userId = 2033;
    
    NSString* destination = [NSString stringWithFormat:@"%d", userId];
    
    
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    
    long checksum = timestamp + userId;
    
    NSString* checkString = [NSString stringWithFormat:@"%ld", checksum];
    checkString = [checkString substringFromIndex:[checkString length]];
    
    destination = [NSString stringWithFormat:@"%@:%f:%@", destination, timestamp, checkString];
    destination = [self Base64Encode:[destination dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString* code = [NSString stringWithFormat:@"/select/%@/%@/%@", token.key, destination, _privateKey];
    NSString * hash = [[self sha1:code] lowercaseString];
    
    NSString* request = [NSString stringWithFormat:@"/select/%@/%@/%@", token.key, destination, hash];
    request = [[request stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    NSString * uri = [NSString stringWithFormat:@"%@%@/", _host, request];
    
    NSLog(@"\nIpsum Request URI: %@\n", uri);
    
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

-(NSString *)Base64Encode:(NSData *)data {
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    /* http://en.wikipedia.org/wiki/Base64
     Text content   M           a           n
     ASCII          77          97          110
     8 Bit pattern  01001101    01100001    01101110
     
     6 Bit pattern  010011  010110  000101  101110
     Index          19      22      5       46
     Base64-encoded T       W       F       u
     */
    
    
    while (inpos < inLength){
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;                          
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer); 
    return pictemp;
}

@end
