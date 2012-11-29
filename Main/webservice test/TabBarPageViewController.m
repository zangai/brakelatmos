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

@synthesize Title, Image;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithJson:(NSDictionary*)json
{
    widgets = [[NSMutableArray alloc] init];
    Title = json[@"title"];
    NSString* imageUrl = [NSString stringWithFormat:@"https://145.48.128.101/images/%@", json[@"image"]];
    NSURL *url = [NSURL URLWithString: imageUrl];
    Image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    NSMutableArray* widgetsArray = json[@"widgets"];
    for (NSDictionary* widgetJson in widgetsArray) {
        NSString* widgetType = widgetJson[@"type"];
        Widget* widget = [Widget makeWidgetWithType:widgetType jsonData:widgetJson];
        [self addWidget:widget];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSLog([NSString stringWithFormat:@"Tab %@ loaded", Title]);
    for (Widget *widget in widgets) {
            [self.view addSubview:widget];
    }
    
    [self.tabBarItem setImage:Image];
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
