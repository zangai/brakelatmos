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

#define VALUE_CLOSED [UIColor redColor]
#define VALUE_OPEN [UIColor blueColor]

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
    
    int buttonHeight = 30;
    int buttonWidth = 200;
    for (int i=0; i <groups.count; i++) {
        
        
        UISwitch* switcher = [UISwitch alloc];
        [switcher initWithFrame: CGRectMake(0, (i*buttonHeight), buttonWidth, buttonHeight) ];
        bool tmp = [[[groups objectAtIndex:i]valueForKey:@"status"] boolValue];
        switcher.tag =i;
        if(tmp){
            [switcher setOn:true];

            switcher.onTintColor = VALUE_OPEN;
        }
        else{
            [switcher setOn:false];
        }
        [switcher addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switcher];
        
//        UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        button.frame = CGRectMake(0, (i * buttonHeight), buttonWidth, buttonHeight);
//        [button setTitle:[NSString stringWithFormat:@"Change Group %d", i] forState:UIControlStateNormal];
//        button.tag = i;
//        button.backgroundColor = VALUE_CLOSED;
//        [button addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
    }
    
    //Confirm button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, (6 * buttonHeight), buttonWidth, buttonHeight);
    [button setTitle:[NSString stringWithFormat:@"Make Changes"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(makeChanges:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
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
    
    if(btn.on)
    {
        change.ChangeValue = 255;
        btn.onTintColor = VALUE_OPEN;
    }
    else
    {
        change.ChangeValue = 0;
        //btn.tintColor = VALUE_CLOSED;
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
