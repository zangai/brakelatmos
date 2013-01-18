//
//  DynamicTabBarViewController.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "DynamicTabBarViewController.h"
#import "TabBarPageViewController.h"
#import "APILibrary.h"
#import "dataStorage.h"

@interface DynamicTabBarViewController ()

@end

@implementation DynamicTabBarViewController

@synthesize buildingId;
//@synthesize tabBar;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"Loading XML Layout");
    
    //UIImage *bannerImage = [UIImage imageNamed:@"header"];
    //UIImageView* banner = [[UIImageView alloc] initWithImage:bannerImage];
    //banner.frame = CGRectMake(0.0, 0, 1024, 100.0);
    //[self.window addSubview:banner];
    //[self addChildViewController:banner];
    
    
    NSString* userToken = [[dataStorage sharedManager] getUserToken];
    
    //testValues
    buildingId = [[dataStorage sharedManager] buildingId];
    //userToken = @"C02417A2-E542-442C-ADBB-F2B01214F355";
    
    NSString* formData = [NSString stringWithFormat:@"userToken=%@&buildingId=%d", userToken, buildingId];
    self.navigationController.toolbar.hidden = FALSE;
    APILibrary* lib = [[APILibrary alloc] init];
    [lib makeApiCall:@"getLayout" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];

}

-(void)callHandler:(id)caller response:(NSData *) response
{
    NSError *myError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    NSString* layoutString = json[@"layout"];
    NSData* layoutData = [layoutString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *layout = [NSJSONSerialization JSONObjectWithData:layoutData options:NSJSONReadingMutableLeaves error:&myError];
    
    [self makeTabsFromJSON:layout];
    [self styleTabbar];
}

-(void)styleTabbar
{
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
    
}

-(void) makeTabsFromJSON:(NSDictionary*) json
{
    NSMutableArray* tabs = [[NSMutableArray alloc] init];
    NSMutableArray *pages = json[@"pages"];
    UIImage *img;
    UIImage *selImg;
    for (NSDictionary* pageJson in pages) {
    //for (int i =0; i <5; i++) {
        TabBarPageViewController* tabBar = [[TabBarPageViewController alloc] initWithJson:pageJson];
        if([tabBar.Title isEqualToString:@"Home"]){
            img  = [UIImage imageNamed:@"home.png"];
            selImg = [UIImage imageNamed:@"home_selected.png"];
        }
        if([tabBar.Title isEqualToString:@"Control"]){
            img  = [UIImage imageNamed:@"control.png"];
            selImg = [UIImage imageNamed:@"control_selected.png"];
        }
        if([tabBar.Title isEqualToString:@"Meteo"]){
            img  = [UIImage imageNamed:@"meteo.png"];
            selImg = [UIImage imageNamed:@"meteo_selected.png"];
        }
        if([tabBar.Title isEqualToString:@"Lucht"]){
            img  = [UIImage imageNamed:@"lucht.png"];
            selImg = [UIImage imageNamed:@"lucht_selected.png"];
        }
        
        UITabBarItem* ctabBarItem = [[UITabBarItem alloc] initWithTitle:/*tabBar.Title*/@"" image:nil tag:tabs.count];
        [ctabBarItem setFinishedSelectedImage:selImg withFinishedUnselectedImage:img];
        //[ctabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        //                                        [UIColor blackColor], UITextAttributeTextColor,[UIColor grayColor], UITextAttributeTextShadowColor,
        //                                         nil] forState:UIControlStateNormal];
        
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:tabBar];
     
        [controller setTabBarItem:ctabBarItem];
        [tabs addObject:controller];
    }
    self.viewControllers = [NSArray arrayWithArray:tabs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
