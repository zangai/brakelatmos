//
//  CarouselViewController.m
//  webservice test
//
//  Created by Luc Rosenbrand on 10/11/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "CarouselViewController.h"

@interface CarouselViewController()

@end

@implementation CarouselViewController
{
    NSMutableData *receivedData;
    NSString *baseAPIUrl;
    NSMutableArray *trustedHosts;
}
@synthesize GUID;
@synthesize carousel;
@synthesize label;
@synthesize wrap;
@synthesize animals, descriptions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    carousel.type = iCarouselTypeCoverFlow2;
    [super viewDidLoad];
   
    baseAPIUrl = @"https://atm-vserver2.avans.nl/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
    
    NSString *formData = @"userToken=";
    formData = [formData stringByAppendingString:GUID];
        
    [self makeApiCall:@"getBuildings" formdata:formData];
    //[self performSegueWithIdentifier: @"goToOtherPage" sender: self];
}


-(void)makeApiCall:(NSString*)command formdata:(NSString*) parameters
{
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
    NSString *rData = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    
    label.text = rData;
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


- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [animals count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return 7;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //create a numbered view
	UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[animals objectAtIndex:index]]];
	return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return 0;
}


- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 240;
}


- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return wrap;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    [label setText:[NSString stringWithFormat:@"%@", [descriptions objectAtIndex:aCarousel.currentItemIndex]]];
}
@end
