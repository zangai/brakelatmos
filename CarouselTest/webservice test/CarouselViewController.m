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
    int selectedIndex;
}
@synthesize GUID;
@synthesize buildingJSONString;
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
    
    //Parse buildingJSONString JSON (Array with buildings)
    
    self.buildings = [[NSMutableArray alloc] initWithObjects:nil];
    [self fillBuildingArray];
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

-(void)fillBuildingArray
{
    //moet uiteindelijk uit verkregen string/dictionary/file/jsonfile etc worden gehaald, maar voor nu even static
    [self.buildings addObject: @"http://145.48.128.101/images/1.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/2.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/1.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/2.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/1.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/2.png"];
    [self.buildings addObject: @"http://145.48.128.101/images/1.png"];
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
    NSURL *url = [NSURL URLWithString: [buildings objectAtIndex:index]];
   // [NSURL URLWithString: [urlArray objectAtIndex:btnN]
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    //view  = [[UIImageView alloc]] initWithImage:image] ;
    view = [[UIImageView alloc] initWithImage:image];
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
