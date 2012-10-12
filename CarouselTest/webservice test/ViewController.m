//
//  ViewController.m
//  webservice test
//
//  Created by Luc Rosenbrand on 10/2/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "ViewController.h"
#import "CarouselViewController.h"
#import <CommonCrypto/CommonDigest.h>


@interface ViewController ()
@end

@implementation ViewController{
    NSMutableData *receivedData;
    NSString *GUID;
    NSString* buildingJSONString;
    NSString *baseAPIUrl;
    NSMutableArray *trustedHosts;
}

@synthesize GebruikerText;
@synthesize WachtwoordText;
@synthesize tokenLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    GUID = @"";
    buildingJSONString = @"";
    baseAPIUrl = @"https://atm-vserver2.avans.nl/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)logIn:(id)sender {
    NSString* username = GebruikerText.text;
    if([username isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Geen gebruikersnaam"
                                                        message:@"Er is geen gebruikersnaam opgegeven"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSString* password = WachtwoordText.text;
        if([password isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Geen wachtwoord"
                                                            message:@"Er is geen wachtwoord opgegeven"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            NSString *hash = [self sha1: [password stringByAppendingString:[self sha1:password]]];
            
            NSString *formData = @"username=";
            formData = [formData stringByAppendingString:username];
            formData = [formData stringByAppendingString:@"&hash="];
            
            formData = [formData stringByAppendingString:hash];
            [self makeApiCall:@"login" formdata:formData];
        }
    }
}

-(void)makeApiCall:(NSString*)command data:(NSString*) parameters
{
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    
    //Parse JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self->receivedData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        NSString *keyAsString = (NSString *)key;
        NSLog(keyAsString);
        
        id value = [res objectForKey:key];
        NSString *valueAsString = (NSString *)value;
        NSLog(valueAsString);
        
        if([keyAsString isEqualToString:@"userToken"])
        {
            GUID = valueAsString; //[[NSString alloc] initWithData:valueAsString encoding:NSASCIIStringEncoding];
            
            if([GUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ongeldige inloggegevens"
                                                                message:@"De opgegeven gebruiksnaam en wachtwoord komen niet overeen met gegevens in het systeem."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                NSString *formData = @"userToken=";
                formData = [formData stringByAppendingString:GUID];
                
                [self makeApiCall:@"getBuildings" formdata:formData];
                break;
            }
        }
        else if([keyAsString isEqualToString:@"buildings"])
        {
            //CarouselViewController *myNewVC = [[CarouselViewController alloc] init];
            //myNewVC.GUID = GUID;
            //[self presentModalViewController:myNewVC animated:YES];
            
            buildingJSONString = valueAsString;
            
            [self performSegueWithIdentifier:@"goToCarousel" sender:self];
            break;
        }
        else if([keyAsString isEqualToString:@"error"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:valueAsString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
        else
        {
            //Should not happen, but still....
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:keyAsString
                                                            message:valueAsString
                                                           delegate:nil
                                                  cancelButtonTitle:@"LOL"
                                                  otherButtonTitles:nil];
            [alert show];
        }
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


- (void)viewDidUnload {
    [self setWachtwoordText:nil];
    [self setGebruikerText:nil];
    [self setTokenLabel:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToCarousel"]) {
        
        // Get destination view
        CarouselViewController *vc = [segue destinationViewController];
        
        vc.GUID = GUID;
        vc.buildingJSONString = buildingJSONString;
    }
}

@end
