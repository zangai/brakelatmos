//
//  CarouselViewController.m
//  webservice test
//
//  Created by Luc Rosenbrand on 10/11/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "CarouselViewController.h"

#import "Building.h"

#import "RoomsViewController.h"

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
@synthesize buildings;
@synthesize al;


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
    
    
    //load from singleton ofzo
    
    //Parse buildingJSONString JSON (Array with buildings)
    dataStorage *sharedManager = [dataStorage sharedManager];
    self.buildings = [[NSMutableArray alloc] initWithArray:sharedManager.buildings];

}

- (void)viewDidLoad
{
        
    carousel.type = iCarouselTypeCoverFlow2;
    [super viewDidLoad];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    [singleFingerTap release];
    
    wrap = NO;
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
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
    Building* building = [buildings objectAtIndex:index];
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	UIView *view = [[UIImageView alloc] initWithImage:[building getImage]];
    //Alarm *al = [[Alarm alloc]initWithFrame:(CGRectMake(0, 0, 0, 0)) :view];
    //[al setNeedsDisplay];
	return view;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    Building* building = [buildings objectAtIndex:index];
    //view  = [[UIImageView alloc]] initWithImage:image] ;
    view = [[UIImageView alloc] initWithImage:[building getImage]];

    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];

    [view addGestureRecognizer:tap];
    if(building.hasAlarm)
    {
    al = [[Alarm alloc]init];
    [al drawTheRed:view];
    }
    return view;
}

- (void)imageTapped:(UITapGestureRecognizer *)sender
{
    Building* building = [buildings objectAtIndex:selectedIndex];
    [[dataStorage sharedManager] setBuildingId:building.BuildingID.integerValue];
    [[dataStorage sharedManager] setBuildingTitle:building.BuildingName];
    [self performSegueWithIdentifier:@"goToFloorView" sender:self];
    
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
    [label setText:[NSString stringWithFormat:@"Gebouw %d", aCarousel.currentItemIndex]];
    selectedIndex = aCarousel.currentItemIndex;
}

@end
