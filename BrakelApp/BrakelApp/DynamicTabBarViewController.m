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
    buildingId = 1;
    userToken = @"C02417A2-E542-442C-ADBB-F2B01214F355";
    
    NSString* formData = [NSString stringWithFormat:@"userToken=%@&buildingId=%d", userToken, buildingId];
    
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
    for (NSDictionary* pageJson in pages) {
    //for (int i =0; i <5; i++) {
        TabBarPageViewController* tabBar = [[TabBarPageViewController alloc] initWithJson:pageJson];
        UITabBarItem* ctabBarItem = [[UITabBarItem alloc] initWithTitle:tabBar.Title image:nil tag:tabs.count];
        [ctabBarItem setFinishedSelectedImage:tabBar.Image withFinishedUnselectedImage:tabBar.Image];
        [ctabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor whiteColor], UITextAttributeTextColor,[UIColor grayColor], UITextAttributeTextShadowColor,
                                                 nil] forState:UIControlStateNormal];
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
