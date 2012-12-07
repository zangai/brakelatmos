//
//  containerViewController.m
//  BrakelApp
//
//  Created by Tjitte de Visscher on 11/30/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "containerViewController.h"


@interface containerViewController ()

@end

@implementation containerViewController

@synthesize container;
@synthesize headerImage;
@synthesize gebouwNaam;

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
    UIColor  *iphoneBlue =
    [UIColor colorWithRed:0.121653f green:0.558395f blue:0.837748f alpha:0];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    int w = self.view.frame.size.width/6;
    int h = self.view.frame.size.height/24;
    int x = widthHeaderImage-(w);
    int y = heightHeaderImage-(h);
    CGRect rect = { {x, y}, {w, h} };
    [button setFrame:rect];
    gebouwNaam = [[UILabel alloc]initWithFrame:CGRectMake(x-(2*w), y, w, h)];
    [gebouwNaam setAdjustsFontSizeToFitWidth:YES];
    [gebouwNaam setText:[[dataStorage sharedManager] buildingTitle]];
    [gebouwNaam setBackgroundColor:iphoneBlue];
    [gebouwNaam setTextColor:[UIColor whiteColor]];
    [gebouwNaam setText:@"Welkom"];
    NSLog(@"Dit is de buildingTitle: %@", [[dataStorage sharedManager] buildingTitle] );
    if([[[dataStorage sharedManager] buildingTitle] isEqualToString:@""])
    {
    }
    else
    {
        [gebouwNaam setText:[[dataStorage sharedManager] buildingTitle]];
        //[self.view addSubview:button];
    }
    [button setTitle:@"Home" forState:UIControlStateNormal];
    [self.view addSubview:gebouwNaam];
    //[button addTarget:self
    //            action:@selector(goToHome)
    //  forControlEvents:UIControlEventTouchUpInside];
}
-(void)goToHome
{
        CarouselViewController *myNewVC = [[CarouselViewController alloc] init];
        
        // do any setup you need for myNewVC
        
        [self presentModalViewController:myNewVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Home:(id)sender {
}
@end
