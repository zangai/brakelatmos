//
//  ViewController.m
//  IpsumTest
//
//  Created by Patrick Decoster on 10/4/12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import "ViewController.h"
#import "Ipsum.h"
#import "Token.h"

@interface ViewController ()
{
    Token* token;
    Ipsum * ipsum;
}
@end

@implementation ViewController

@synthesize tvResponse;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ipsum = [[Ipsum alloc] init:@"E8EB7CBB-6C16-4270-93F7-CABBD1F0FBDF"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getToken:(id)sender {
    [ipsum authenticateWithUsername:@"Breda" Password:@"Breda"];
}

- (IBAction)getLocations:(id)sender {
    [ipsum getLocations: ^(NSString *data){
        tvResponse.text = [NSString stringWithFormat:@"%@", data];
    }];

}

@end
