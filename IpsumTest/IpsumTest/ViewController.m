//
//  ViewController.m
//  IpsumTest
//
//  Created by Patrick Decoster on 10/4/12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "ViewController.h"
#import "Ipsum.h"

@interface ViewController ()
    
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getToken:(id)sender {
    Ipsum * ipsum = [[Ipsum alloc]init:@"E8EB7CBB-6C16-4270-93F7-CABBD1F0FBDF"];
    [ipsum authenticateWithUsername:@"Breda" Password:@"Breda"];
    _rawText.text = [NSString stringWithFormat:@"%@", ipsum.token.expire];
}


@end
