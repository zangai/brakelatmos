//
//  TabBarPageViewController.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "TabBarPageViewController.h"
#import "Widget.h"

@interface TabBarPageViewController ()
{
    NSMutableArray* widgets;
}
@end

@implementation TabBarPageViewController

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
    
    
    NSLog(@"herp");
    for (Widget *widget in widgets) {
        NSLog(widget.description);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addWidget:(Widget*) widget
{
    [widgets addObject:widget];
}
-(void) removeWidget:(Widget*) widget
{
    [widgets removeObject:widget];
}
-(void) removeWidgetAtIndex:(NSUInteger) index
{
    [widgets removeObjectAtIndex:index];
}
-(Widget*) getWidget:(NSUInteger) index
{
    return [widgets objectAtIndex:index];
}

@end
