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

#define VALUE_CLOSED [UIColor redColor]
#define VALUE_OPEN [UIColor blueColor]

@implementation ControlWidget
{
    NSMutableDictionary* changesQueue;
}

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    changesQueue = [[NSMutableDictionary alloc] init];
    
    NSString* formData = [NSString stringWithFormat:@"buildingId=%d", 1];
    [[APILibrary alloc] makeApiCall:@"getGroups" formdata:formData delegate:self handleBy:@selector(makeGroups:)];
    
    return self;
}

-(void)makeGroups:(NSData*)result
{
    NSLog([result description]);
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Control widget is showing now");
    
    int buttonHeight = 30;
    int buttonWidth = 200;
    for (int i=0; i < 4; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.frame = CGRectMake(0, (i * buttonHeight), buttonWidth, buttonHeight);
        [button setTitle:[NSString stringWithFormat:@"Change Group %d", i] forState:UIControlStateNormal];
        button.tag = i;
        button.backgroundColor = VALUE_CLOSED;
        [button addTarget:self action:@selector(queueForChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    //Confirm button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    button.frame = CGRectMake(0, (6 * buttonHeight), buttonWidth, buttonHeight);
    [button setTitle:[NSString stringWithFormat:@"Make Changes"] forState:UIControlStateNormal];
    button.backgroundColor = VALUE_CLOSED;
    [button addTarget:self action:@selector(makeChanges:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

+(ControlWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[ControlWidget alloc] initWithJson:json];
}

- (IBAction)queueForChange:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    Changes* change = [[Changes alloc] init];
    change.GroupID = btn.tag;
    
    if(btn.backgroundColor == VALUE_CLOSED)
    {
        change.ChangeValue = 1;
        btn.backgroundColor = VALUE_OPEN;
    }
    else
    {
        change.ChangeValue = 0;
        btn.backgroundColor = VALUE_CLOSED;
    }
    NSString* key = [NSString stringWithFormat:@"%d", change.GroupID];
    changesQueue[key] = [change toJSONString];    
}

- (IBAction)makeChanges:(id)sender
{
    NSString* changes = @"changes=[";
    Boolean isFirst = true;
    for (NSString* key in changesQueue) {
        NSString* change = changesQueue[key];
        changes = [changes stringByAppendingFormat:@"%@%@", (isFirst ? @"" : @","), change];
        isFirst = false;
    }
    changes = [changes stringByAppendingFormat:@"]"];
    //urlencode(changes);
    
    [[APILibrary alloc] makeApiCall:@"changeGroups" formdata:changes delegate:self handleBy:@selector(groupsChanges:)];
}

-(void)changeGroups:(NSData*)result
{
    NSLog([result description]);
}

@end
