//
//  navViewController.m
//  splitviewtest
//
//  Created by wlmligte on 10/12/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import "navViewController.h"

@interface navViewController ()

@end

@implementation navViewController

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
    
    _tester.text = _text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)verandertekst:(id)sender {
    _tester.text = @"dit was de eerste test";
}

- (void)verandertekst
{
    _tester.text = @"dit was de eerste test";
    
}
@end
