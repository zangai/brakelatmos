//
//  ViewController.m
//  splitviewnormaal
//
//  Created by wlmligte on 11/9/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
}
UIButton* laatsteKnop;

- (void)viewDidLoad
{
    laatsteKnop = 0;
    
    int knopX = 40;
    int knopY = 20;
    NSInteger verdieping = 34586345;
    //_testlabel.text = @"test";
    
    
    //[_liftPlaatje1 setEnabled:NO]; // To toggle enabled / disabled
    
    //UIButton *mijnknop = [UIButton buttonWithType:UIButtonTypeCustom];
    for (NSInteger x = 1; x <= verdieping; x++) {
        //[_liftPlaatje1 setEnabled:NO];
        
        UIButton *liftKnop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [liftKnop setTitle:[NSString stringWithFormat:@"%d", x] forState:UIControlStateNormal];
        
        liftKnop.frame = CGRectMake(knopX, knopY, 70, 70);
        liftKnop.tag = x;
        //CGRectMake(20, 20, 20, 44); // position in the parent view and set the size of the button
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"blue"]  forState:UIControlStateNormal];
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateHighlighted];
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateDisabled];
        //liftKnop.titleLabel.font = [UIFont systemFontOfSize:30];
        [liftKnop.titleLabel setFont:[UIFont  fontWithName:@"Helvetica-Bold" size:30.0]];
        [liftKnop addTarget:self action:@selector(knopDruk:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        [liftKnop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [liftKnop setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_deuiviewnav addSubview:liftKnop];
        if(x % 2){
            knopX = knopX +110;
        }
        else{
            knopY = knopY +90;
            knopX = knopX -110;
        }
        
    }
    _deuiviewnav.frame = CGRectMake(0, 0, 250, knopY + 80);
    [super viewDidLoad];
    /*UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    myButton.frame = CGRectMake(20, 20, 200, 44); // position in the parent view and set the size of the button
    [myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
    [myButton setBackgroundImage:[UIImage imageNamed:@"blue"]  forState:UIControlStateNormal];
    [myButton setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateHighlighted];
    [myButton setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateSelected];
    
    // add targets and actions
    [myButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    //[self.view addSubview:myButton];
     */
}
- (IBAction)knopDruk:(id)sender
{

    if(laatsteKnop != nil){
        [laatsteKnop setEnabled:true];
    }
    else{}
    NSInteger i = [sender tag];
    [sender setEnabled:false];
    _testLabel.text = [NSString stringWithFormat:@"button %d was pressed", i];
    laatsteKnop = sender;
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

@end
