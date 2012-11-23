//
//  LoginViewController.m
//  webservice test
//
//  Created by Luc Rosenbrand on 10/2/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "LoginViewController.h"
#import "CarouselViewController.h"
#import "APILibrary.h"

@interface LoginViewController ()
@end

@implementation LoginViewController{
    NSMutableData *receivedData;
    NSString *GUID;
    NSMutableArray* buildings;
    NSString *baseAPIUrl;
    NSMutableArray *trustedHosts;
}

@synthesize GebruikerText;
@synthesize WachtwoordText;

- (void)viewDidLoad {
    [super viewDidLoad];
    GUID = @"";
    buildings = [[NSMutableArray alloc] init];
    baseAPIUrl = @"https://145.48.128.101/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"145.48.128.101", @"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
    receivedData = [[NSMutableData alloc] init];
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
            formData = [formData stringByAppendingString:@"&device="];
            NSString* deviceId = [[dataStorage sharedManager] getDeviceId];
            formData = [formData stringByAppendingString:deviceId];
            
            APILibrary* lib = [[APILibrary alloc] init];
            [lib makeApiCall:@"login" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];
        }
    }
}

-(void)callHandler:(id)caller response:(NSData *) response {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:response];
    if(receivedData != nil){
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
                [[dataStorage sharedManager] setUserToken:GUID];
                
                NSString *formData = @"userToken=";
                formData = [formData stringByAppendingString:GUID];
                
                //[self makeApiCall:@"getBuildings" formdata:formData];
                [receivedData setLength:0];//empty received data
                APILibrary* lib = [[APILibrary alloc] init];
                [lib makeApiCall:@"getBuildings" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];
                
                break;
            }
        }
        else if([keyAsString isEqualToString:@"buildings"]) {
            id value = [res objectForKey:key];
            [buildings addObjectsFromArray:(NSArray*)value];
            [[dataStorage sharedManager] initArrayLists:buildings];
            
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
}

- (void)viewDidUnload {
    [self setWachtwoordText:nil];
    [self setGebruikerText:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToCarousel"]) {
        
        // Get destination view
       // CarouselViewController *vc = [segue destinationViewController];
        
       // vc.GUID = GUID;
       // vc.buildings = buildings;
        //vc.buildingJSONString = buildingJSONString;
    }
}

@end
