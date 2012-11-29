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
}

-(void) makeTabsFromJSON:(NSDictionary*) json
{
    NSMutableArray* tabs = [[NSMutableArray alloc] init];
    NSMutableArray *pages = json[@"pages"];
    for (NSDictionary* pageJson in pages) {
    //for (int i =0; i <5; i++) {
        TabBarPageViewController* tabBar = [[TabBarPageViewController alloc] initWithJson:pageJson];
        UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:tabBar.Title image:tabBar.Image tag:tabs.count];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:tabBar];
        [controller setTabBarItem:tabBarItem];
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
