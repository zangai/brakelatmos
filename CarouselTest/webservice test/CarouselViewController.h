//
//  CarouselViewController.h
//  webservice test
//
//  Created by Luc Rosenbrand on 10/11/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselViewController.h"
#import "iCarousel.h"

@interface CarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic, retain) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) BOOL wrap;
@property (strong, nonatomic) NSMutableArray *buildings;
@property (strong, nonatomic) NSMutableArray *descriptions;
@property (strong, nonatomic) NSString *GUID;
@end
