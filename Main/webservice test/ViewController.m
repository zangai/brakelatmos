//
//  ViewController.m
//  webservice test
//
//  Created by Luc Rosenbrand on 10/2/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "ViewController.h"
#import "CarouselViewController.h"
#import "APILibrary.h"

@interface ViewController ()
@end

@implementation ViewController{
    NSMutableData *receivedData;
    NSString *GUID;
    NSMutableArray* buildings;
    NSString *baseAPIUrl;
    NSMutableArray *trustedHosts;
}

@synthesize GebruikerText;
@synthesize WachtwoordText;
@synthesize tokenLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    GUID = @"";
    buildings = [[NSMutableArray alloc] init];
    baseAPIUrl = @"https://145.48.128.101/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"145.48.128.101", @"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            NSString *hash = [APILibrary sha1: [password stringByAppendingString:[APILibrary sha1:password]]];
            
            NSString *formData = @"username=";
            formData = [formData stringByAppendingString:username];
            formData = [formData stringByAppendingString:@"&hash="];
            
            formData = [formData stringByAppendingString:hash];
            //[self makeApiCall:@"login" formdata:formData];
            
            APILibrary* lib = [[APILibrary alloc] init];
            [lib makeApiCall:@"login" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];
        }
    }
}

-(void)callHandler:(id)caller response:(NSData *) response {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:response];
    
    //Parse JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self->receivedData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        NSString *keyAsString = (NSString *)key;
        NSLog(keyAsString);
        
        if([keyAsString isEqualToString:@"userToken"]) {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
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
                
                //[self makeApiCall:@"getBuildings" formdata:formData];
                APILibrary* lib = [[APILibrary alloc] init];
                [lib makeApiCall:@"getBuildings" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];
                break;
            }
        }
        else if([keyAsString isEqualToString:@"buildings"]) {
            id value = [res objectForKey:key];
            [buildings addObjectsFromArray:(NSArray*)value];
            //NSLog(valueAsString);
            //buildingJSONString = valueAsString;
            
            [self performSegueWithIdentifier:@"goToCarousel" sender:self];
            break;
        }
        else if([keyAsString isEqualToString:@"error"]) {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:valueAsString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        else {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
            
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


/*
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

-(void)didReceiveData:(NSData*) data
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
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
        
        if([keyAsString isEqualToString:@"userToken"]) {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
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
        else if([keyAsString isEqualToString:@"buildings"]) {
            id value = [res objectForKey:key];
            [buildings addObjectsFromArray:(NSArray*)value];
            //NSLog(valueAsString);
            //buildingJSONString = valueAsString;
            
            [self performSegueWithIdentifier:@"goToCarousel" sender:self];
            break;
        }
        else if([keyAsString isEqualToString:@"error"]) {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:valueAsString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
        else {
            NSString* valueAsString = (NSString *)[res objectForKey:key];
            NSLog(valueAsString);
            
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
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([trustedHosts containsObject:challenge.protectionSpace.host]) {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
                 forAuthenticationChallenge:challenge];
        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
*/

- (void)viewDidUnload {
    [self setWachtwoordText:nil];
    [self setGebruikerText:nil];
    [self setTokenLabel:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToCarousel"]) {
        
        // Get destination view
        CarouselViewController *vc = [segue destinationViewController];
        
        vc.GUID = GUID;
        vc.buildings = buildings;
        //vc.buildingJSONString = buildingJSONString;
    }
}

@end
