//
//  ViewController.h
//  LoginTest
//
//  Created by CHRISTIAAN Rakowski on 10/11/12.
//  Copyright (c) 2012 Christiaan Rakowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)loginClicked:(id)sender;
- (IBAction)getBuidlingsClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
