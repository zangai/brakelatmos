//
//  widgetTestVCViewController.m
//  BrakelApp
//
//  Created by Joost on 06-12-12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "widgetTestVCViewController.h"
#import "CO2Widget.h"

@interface widgetTestVCViewController ()

@end

@implementation widgetTestVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CO2Widget *coWidget = [[CO2Widget alloc]initWithFrame:self.view.frame];
        [self.view addSubview:coWidget];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	CO2Widget *coWidget = [[CO2Widget alloc]initWithFrame:CGRectMake(0,0,1024,768)];
    [self.view addSubview:coWidget];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
