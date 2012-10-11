//
//  ViewController.h
//  webservice test
//
//  Created by Luc Rosenbrand on 10/2/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)logIn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getBuildings;
@property (weak, nonatomic) IBOutlet UITextField *WachtwoordText;
@property (weak, nonatomic) IBOutlet UITextField *GebruikerText;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet UIButton *getBuildingsButton;
- (IBAction)getBuildings:(id)sender;

@end
