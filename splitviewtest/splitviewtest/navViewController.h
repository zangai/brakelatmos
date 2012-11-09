//
//  navViewController.h
//  splitviewtest
//
//  Created by wlmligte on 10/12/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tester;
- (IBAction)verandertekst:(id)sender;
@property (strong, nonatomic) NSString* text;

-(void)verandertekst;

@end
