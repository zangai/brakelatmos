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
    UIButton* confirmButton;
}

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    changesQueue = [[NSMutableDictionary alloc] init];
    groups = [[NSMutableArray alloc]init];
    receivedData = [[NSMutableData alloc] init];
    confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
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
        groups = [res valueForKey:@"groups"];
    }
    
    int buttonHeight = 30;
    int buttonWidth = 200;
    for (int i=0; i <groups.count; i++) {
        UISwitch* switcher = [UISwitch alloc];
        UILabel* lab = [ [UILabel alloc ] initWithFrame:CGRectMake(0, (i*2*buttonHeight), 150, buttonHeight)];
        
        [lab setTextAlignment:NSTextAlignmentRight];
        NSString* groupname = [[groups objectAtIndex:i]valueForKey:@"GroupName"];
        [lab setText:groupname];
        [switcher initWithFrame: CGRectMake(180, (i*2*buttonHeight), buttonWidth, buttonHeight) ];
        int tmp = [[[groups objectAtIndex:i]valueForKey:@"ChangeValue"] integerValue];
        switcher.tag =[[[groups objectAtIndex:i]valueForKey:@"GroupID"] integerValue];
        if(tmp>128){
            [switcher setOn:true];
            switcher.onTintColor = VALUE_OPEN;
        }
        else if(tmp<128){
            [switcher setOn:false];
        }
        [switcher addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lab];
        [self addSubview:switcher];
    }
    
    //Confirm button
    
    confirmButton.frame = CGRectMake(0, ((groups.count *2)* buttonHeight), buttonWidth, buttonHeight);
    [confirmButton setTitle:[NSString stringWithFormat:@"Make Changes"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(makeChanges:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setEnabled:false];
    [self addSubview:confirmButton];
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Control widget is showing now");
    
    
}

+(ControlWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[ControlWidget alloc] initWithJson:json];
}

- (IBAction)queueForChange:(id)sender
{
    [confirmButton setEnabled:true];
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
    bool hasFinishedWithErrors;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&myError];
    //NSString* layoutString = json[@"changes"];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[json valueForKey:@"changes"]];
    NSLog([arr description]);
    for(int i = 0; i < arr.count; i++){
        if( ! [[[arr objectAtIndex:i]valueForKey:@"ChangeStatus"]boolValue])
        {
            hasFinishedWithErrors = true;
        }
    }
    
    if(hasFinishedWithErrors)
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"One or more groups could not be changed" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK" , nil];
        [alertView show];
        hasFinishedWithErrors = false;
    }
    //NSLog([json description]);
    
    
    
    
    
}

@end
