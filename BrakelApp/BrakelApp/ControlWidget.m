//
//  ControlWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/29/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "ControlWidget.h"
#import "Changes.h"
#import "APILibrary.h"
#include "dataStorage.h"

#define VALUE_CLOSED [UIColor colorWithRed:0.8 green:0.2 blue:0.0 alpha:1.0]
#define VALUE_OPEN [UIColor greenColor]

@implementation ControlWidget
{
    NSMutableDictionary* changesQueue;
    NSMutableArray* groups;
    NSMutableData* receivedData;
}

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    changesQueue = [[NSMutableDictionary alloc] init];
    groups = [[NSMutableArray alloc]init];
    receivedData = [[NSMutableData alloc] init];
    
    dataStorage *sharedManager = [dataStorage sharedManager];
    NSInteger buildingIdentifier = sharedManager.buildingId;
    NSString* userToken = [sharedManager getUserToken];
    APILibrary* lib = [[APILibrary alloc] init];
    
    NSString *formData = @"userToken=";
    formData = [formData stringByAppendingString:userToken];
    formData = [formData stringByAppendingString:@"&buildingId="];
    formData = [formData stringByAppendingFormat:@"%d", buildingIdentifier];
    [lib makeApiCall:@"getGroups" formdata:formData delegate:self handleBy:@selector(makeGroups:response:)];
    
    
    return self;
}

-(void)makeGroups:(id)caller response:(NSData*)response
{
    NSLog([response description]);
    [receivedData appendData:response];
    if(receivedData != nil){
        //Parse JSON
        NSError *myError = nil;
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self->receivedData options:NSJSONReadingMutableLeaves error:&myError];
        groups = [res valueForKey:@"group"];
    }
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Control widget is showing now");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1,0,0,0.75);
    
    //CGRect rect = [CGRectMake(rect.origin.x+100, rect.origin.y+50, rect.size.width, rect.size.height)]
    NSInteger radius = 100;
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                    radius, M_PI, M_PI / 2, 1); //STS fixed
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                    rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                    radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                    -M_PI / 2, M_PI, 1);
    
    CGContextFillPath(context);
    
    int buttonHeight = 30;
    int buttonWidth = 100;
    for (int i=0; i < 4; i++) {
        UISwitch* switc = [[UISwitch alloc] init];
        UILabel* label = [[UILabel alloc]init];
        switc.frame = CGRectMake(0, (i * buttonHeight), buttonWidth, buttonHeight);
        label.frame = CGRectMake(buttonWidth + 10, (i * buttonHeight), buttonWidth, buttonHeight);
        label.text = [NSString stringWithFormat:@"Groep %i",i];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        switc.tag = i;
        switc.backgroundColor = VALUE_CLOSED;
        [switc addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
        switc.alpha = 0.5;
        [self addSubview:switc];
        [self addSubview:label];
    }
    
    //Confirm button
    UISwitch* switcer = [[UISwitch alloc] init];
    switcer.frame = CGRectMake(0, (6 * buttonHeight), buttonWidth, buttonHeight);
    switcer.backgroundColor = VALUE_CLOSED;
    [switcer addTarget:self action:@selector(makeChanges:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switcer];
    
}

+(ControlWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[ControlWidget alloc] initWithJson:json];
}

- (IBAction)queueForChange:(id)sender
{
    UISwitch* btn = (UISwitch*)sender;
    Changes* change = [[Changes alloc] init];
    change.GroupID = btn.tag;
    
    if(btn.backgroundColor != VALUE_OPEN)
    {
        change.ChangeValue = 1;
        btn.backgroundColor = VALUE_OPEN;
        btn.alpha = 1.0;
    }
    else
    {
        change.ChangeValue = 0;
        btn.backgroundColor = VALUE_CLOSED;
        btn.alpha = 0.5;
    }
    NSString* key = [NSString stringWithFormat:@"%d", change.GroupID];
    changesQueue[key] = [change toJSONString];    
}

- (IBAction)makeChanges:(id)sender
{
    NSString* userToken = [[dataStorage sharedManager] getUserToken];
    //userToken = @"C02417A2-E542-442C-ADBB-F2B01214F355";
    
    NSInteger buildingId = [[dataStorage sharedManager] buildingId];
    //buildingId = 1;
    
    NSString* changes = [NSString stringWithFormat:@"userToken=%@&buildingId=%d&changes=[", userToken, buildingId];
    Boolean isFirst = true;
    for (NSString* key in changesQueue) {
        NSString* change = changesQueue[key];
        changes = [changes stringByAppendingFormat:@"%@%@", (isFirst ? @"" : @","), change];
        isFirst = false;
    }
    changes = [changes stringByAppendingFormat:@"]"];
    //urlencode(changes);
    
    APILibrary* lib = [[APILibrary alloc] init];
    [lib makeApiCall:@"changeGroups" formdata:changes delegate:self handleBy:@selector(changeGroups:response:)];
}

-(void)changeGroups:(id)caller response:(NSData*)response
{
    NSError *myError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    //NSString* layoutString = json[@"changes"];
    NSLog([json description]);
}

@end
