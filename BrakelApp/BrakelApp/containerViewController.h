//
//  containerViewController.h
//  BrakelApp
//
//  Created by Tjitte de Visscher on 11/30/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "dataStorage.h"
#import "CarouselViewController.h"

#define heightHeaderImage 160
#define widthHeaderImage    1024
#define terugKnopTekst  "Kies ander gebouw"

@interface containerViewController : UIViewController
{
    UILabel* gebouwNaam;
}
@property (weak, nonatomic) IBOutlet UIViewController *container;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) UILabel * gebouwNaam;
- (IBAction)Home:(id)sender;



@end
