//
//  TabBarPageViewController.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Widget.h"

@interface TabBarPageViewController : UIViewController

@property (nonatomic, strong) NSString* Title;
@property (nonatomic, strong) UIImage* Image;

-(id)initWithJson:(NSDictionary*)json;
-(void) addWidget:(Widget*) widget;
-(void) removeWidget:(Widget*) widget;
-(void) removeWidgetAtIndex:(NSUInteger) index;
-(Widget*) getWidget:(NSUInteger) index;

@end
