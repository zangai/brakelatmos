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

@interface DynamicTabBarViewController ()

@end

@implementation DynamicTabBarViewController

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
    
    //APILibrary* lib = [[APILibrary alloc] init];
    //[lib makeApiCall:@"getLayout" formdata:@""];
    [self makeTabsFromJSON:nil];
}

-(void) makeTabsFromJSON:(NSDictionary*) json
{
    NSMutableArray* tabs = [[NSMutableArray alloc] init];
    
    //for (NSDictionary* obj in json) {
        //do stuff
    //}
    for (int i =0; i <5; i++) {
        TabBarPageViewController* tabBar = [[TabBarPageViewController alloc] init];
        UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"Tab %d", i] image:nil tag:i];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController: tabBar];
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
