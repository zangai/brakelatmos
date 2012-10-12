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
    NSString* buildingsJSON;
    int selectedIndex;
}
@synthesize GUID;
@synthesize carousel;
@synthesize label;
@synthesize wrap;
@synthesize buildings, descriptions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
    self.buildings = [NSMutableArray arrayWithObjects:@"Bear.png",
                    @"Zebra.png",
                    @"Tiger.png",
                    @"Goat.png",
                    @"Birds.png",
                    @"Giraffe.png",
                    @"Chimp.png",
                    nil];
    self.descriptions = [NSMutableArray arrayWithObjects:@"Bears Eat: Honey",
                         @"Zebras Eat: Grass",
                         @"Tigers Eat: Meat",
                         @"Goats Eat: Weeds",
                         @"Birds Eat: Seeds",
                         @"Giraffes Eat: Trees",
                         @"Chimps Eat: Bananas",
                         nil];
}

- (void)viewDidLoad
{
    carousel.type = iCarouselTypeCoverFlow2;
    [super viewDidLoad];
    wrap = NO;
    
    baseAPIUrl = @"https://atm-vserver2.avans.nl/api.ashx?command=";
    trustedHosts = [[NSMutableArray alloc] init];
    trustedHosts = [NSMutableArray arrayWithObjects:@"atm-vserver2.avans.nl", @"avans.nl", @"ipsum.groep-t.be", nil];
    
    NSString *formData = @"userToken=";
    formData = [formData stringByAppendingString:GUID];
    
    [self makeApiCall:@"getBuildings" formdata:formData];
    //parse buildingsJSON for buildings
}

-(void)makeApiCall:(NSString*)command formdata:(NSString*) parameters {
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
    buildingsJSON = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
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
    return [buildings count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //create a numbered view
	UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[buildings objectAtIndex:index]]];
	return view;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{   
    view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[buildings objectAtIndex:index]]];
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
    return 300;//240
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    [label setText:[NSString stringWithFormat:@"%@", [descriptions objectAtIndex:aCarousel.currentItemIndex]]];
    selectedIndex = aCarousel.currentItemIndex;
}

@end
