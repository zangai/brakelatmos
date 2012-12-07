//
//  WindWidget.m
//  BrakelApp
//
//  Created by wlmligte on 12/6/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "WindWidget.h"
#import "APILibrary.h"

@implementation WindWidget

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];

    NSString* formData = [NSString stringWithFormat:@"buildingId=%d", 1];
    [[APILibrary alloc] makeApiCall:@"getGroups" formdata:formData delegate:self handleBy:@selector(makeGroups:response:)];
    
    return self;
}

+(WindWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[WindWidget alloc] initWithJson:json];
}
- (void)drawRect:(CGRect)rect
{
    int windSnelheid = 5;
    int windRichting = 250;
    int buttonHeight = 30;
    int buttonWidth = 200;
    
    //UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //imgView.image = [UIImage imageNamed:@"image.png"];
    
    UIImageView* windPlaatje = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [windPlaatje setImage: [UIImage imageNamed:@"compass.png"]];
    windPlaatje.backgroundColor = [UIColor whiteColor];
    UIImageView* windRoos = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [windRoos setImage: [UIImage imageNamed:@"windroos.png"]];
    windRoos.transform = CGAffineTransformMakeRotation(windRichting);
    UILabel* windsnelheidlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    windsnelheidlabel.text = [NSString stringWithFormat:@"%d km/h",windSnelheid];
    UILabel* windRichtingText = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 20, 200)];
    
    //NSString *string = [NSString stringWithFormat:@"%d", theinteger];
    //self.windPlaatje.image = windPlaatje.image;
    
    //Widget.imageView.image = windPlaatje.image;
    //windPlaatje.size = [CGSizeMake(50, 50)];
    //[_mainView setImage:image];
    //[windPlaatje setImage:windPlaatje.image];
    [self addSubview:windPlaatje];
    [self addSubview:windRoos];
    [self addSubview:windsnelheidlabel];
    
    //windPlaatje.frame = CGRectMake(0, (i * buttonHeight), buttonWidth, buttonHeight);
    //[self setImage:windPlaatje]
    
    
    //UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    //[_mainView setImage:image];
//    NSLog(@"Control widget is showing now");
//    
//    int buttonHeight = 30;
//    int buttonWidth = 200;
//    for (int i=0; i < 4; i++) {
//        UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        button.frame = CGRectMake(0, (i * buttonHeight), buttonWidth, buttonHeight);
//        [button setTitle:[NSString stringWithFormat:@"Change Group %d", i] forState:UIControlStateNormal];
//        button.tag = i;
//        //button.backgroundColor = VALUE_CLOSED;
//        [button addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//    }
//    
//    //Confirm button
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    button.frame = CGRectMake(0, (6 * buttonHeight), buttonWidth, buttonHeight);
//    [button setTitle:[NSString stringWithFormat:@"Make Changes"] forState:UIControlStateNormal];
//    //button.backgroundColor = VALUE_CLOSED;
//    [button addTarget:self action:@selector(makeChanges:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
