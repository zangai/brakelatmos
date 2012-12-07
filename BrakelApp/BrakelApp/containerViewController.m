//
//  containerViewController.m
//  BrakelApp
//
//  Created by Tjitte de Visscher on 11/30/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "containerViewController.h"
#import "dataStorage.h"

@interface containerViewController ()

@end

@implementation containerViewController

@synthesize container;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    int w = 100;
    int h = 30;
    int x = (self.view.frame.size.width - w);
    int y = 50;
    CGRect rect = { {x, y}, {w, h} };
    [button setFrame:rect];
    [button setTitle:[[dataStorage sharedManager] buildingTitle] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
