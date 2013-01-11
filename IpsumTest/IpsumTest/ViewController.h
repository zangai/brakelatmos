//
//  ViewController.h
//  IpsumTest
//
//  Created by Patrick Decoster on 10/4/12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)getToken:(id)sender;
- (IBAction)getLocations:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *tvResponse;

@end
