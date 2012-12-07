//
//  LoginViewController.h
//  BrakelApp
//
//  Created by wlmligte on 11/16/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *GebruikerText;
@property (strong, nonatomic) IBOutlet UITextField *WachtwoordText;

- (IBAction)logIn:(id)sender;
-(id)initWithNib;

@end
