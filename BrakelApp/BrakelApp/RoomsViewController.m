//
//  RoomsViewController.m
//  splitviewnormaal
//
//  Created by wlmligte on 11/9/12.
//  Copyright (c) 2012 wlmligte. All rights reserved.
//

#import "RoomsViewController.h"
#import "room.h"
#import <QuartzCore/QuartzCore.h>
#import "dataStorage.h"
#import "DynamicTabBarViewController.h"
#import "APILibrary.h"

@interface RoomsViewController ()

@end

@implementation RoomsViewController
{
    NSMutableArray *floors;
    NSMutableArray *rooms;
    NSMutableData *receivedData;
}

@synthesize buildingIdentifier;
 @synthesize al;

UIButton* laatsteKnop;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self viewBackground
    rooms = [[NSMutableArray alloc] init];
    laatsteKnop = 0;
    receivedData = [[NSMutableData alloc] init];
    
    dataStorage *sharedManager = [dataStorage sharedManager];    
    buildingIdentifier = sharedManager.buildingId;
    NSString* userToken = [sharedManager getUserToken];
    APILibrary* lib = [[APILibrary alloc] init];
    
    NSString *formData = @"userToken=";
    formData = [formData stringByAppendingString:userToken];
    formData = [formData stringByAppendingString:@"&buildingId="];
    formData = [formData stringByAppendingFormat:@"%d", buildingIdentifier];
    formData = [formData stringByAppendingString:@"&getRooms=true"];
    [lib makeApiCall:@"getFloors" formdata:formData delegate:self handleBy:@selector(callHandler:response:)];
}

-(void)callHandler:(id)caller response:(NSData *) response {
    [receivedData appendData:response];
    if(receivedData != nil){
        //Parse JSON
        NSError *myError = nil;
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self->receivedData options:NSJSONReadingMutableLeaves error:&myError];
        floors = [res valueForKey:@"floors"];

        //Creating elevator buttons
        int knopX = 0;
        int knopY = 115;
        UIButton *homeKnop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        homeKnop.frame = CGRectMake(0, 0, 245, 100);
        [homeKnop setTitle:@"Home" forState:UIControlStateNormal];
        [homeKnop setTag:[[dataStorage sharedManager] buildingId]];
        [homeKnop setBackgroundImage:[UIImage imageNamed:@"buttonBlauw.png"]  forState:UIControlStateNormal];
        [homeKnop setBackgroundImage:[UIImage imageNamed:@"buttonBlauw.png"] forState:UIControlStateHighlighted];
        [homeKnop setBackgroundImage:[UIImage imageNamed:@"buttonDonkerBlauw"] forState:UIControlStateDisabled];
        [homeKnop addTarget:self action:@selector(knopDruk:) forControlEvents:UIControlEventTouchDown];
        [homeKnop.titleLabel setFont:[UIFont  fontWithName:@"Helvetica-Bold" size:30.0]];
        
        [_deuiviewnav addSubview:homeKnop];
        
        
        
        
        for (NSInteger x = 0; x < floors.count; x++) {
            
            
            UIButton *liftKnop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
           
            if (x == 0)
            {
                [liftKnop setTitle:[NSString stringWithFormat:@"Begane Grond"] forState:UIControlStateNormal];
            }
            else
            {
                [liftKnop setTitle:[NSString stringWithFormat:@"verdieping %d", x] forState:UIControlStateNormal];
            }
            liftKnop.frame = CGRectMake(knopX, knopY, 245, 100);
            
            liftKnop.tag = [[[floors objectAtIndex:x] valueForKey:@"BuildingID"] integerValue];
            [liftKnop setBackgroundColor:[UIColor whiteColor]];
            [liftKnop setBackgroundImage:[UIImage imageNamed:@"buttonBlauw.png"]  forState:UIControlStateNormal];
            [liftKnop setBackgroundImage:[UIImage imageNamed:@"buttonBlauw.png"] forState:UIControlStateHighlighted];
            [liftKnop setBackgroundImage:[UIImage imageNamed:@"backgroundgrey.png"] forState:UIControlStateDisabled];
            [liftKnop.titleLabel setFont:[UIFont  fontWithName:@"Helvetica-Bold" size:30.0]];
            [liftKnop addTarget:self action:@selector(knopDruk:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
            [liftKnop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [liftKnop setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
            
            if([[[floors objectAtIndex:x]valueForKey:@"HasAlarm"]boolValue]){
                [liftKnop setBackgroundImage:[UIImage imageNamed:@"buttonRood.png"] forState:UIControlStateNormal];
            }
            
            [_deuiviewnav addSubview:liftKnop];
            
            knopY = knopY +100;

        }
        
        //knopY = knopY /2;
        _deuiviewnav.frame = CGRectMake(0, 0, 250, knopY);
        //_deuiviewnav2.frame = CGRectMake(0, 0, 250, knopY);
        //[self.view
                
        //_deuiviewnav.frame.size.height = 1800;
        
        //Adding ALL the rooms to the rooms array
        NSMutableArray* tmp = [floors valueForKey:@"Rooms"];
        for(NSArray* roomsPerFloor in tmp)
        {
            for(NSObject* actualRoom in roomsPerFloor)
            {
                NSInteger x = [[actualRoom valueForKey:@"X"] integerValue];
                NSInteger y = [[actualRoom valueForKey:@"Y"] integerValue];
                NSInteger width = [[actualRoom valueForKey:@"Width"] integerValue];
                NSInteger height = [[actualRoom valueForKey:@"Height"] integerValue];
                CGRect r = CGRectMake(x, y, width, height);
                BOOL enabled = [[actualRoom valueForKey:@"Enabled"] boolValue];
                BOOL alarm = [[actualRoom valueForKey:@"HasAlarm"] boolValue];
                NSString* name = [actualRoom valueForKey:@"RoomName"];
                NSInteger floorID = [[actualRoom valueForKey:@"BuildingID"] integerValue];
                NSInteger roomID = [[actualRoom valueForKey:@"RoomID"] integerValue];
                

                Room* room =[[Room alloc] initWithRect:r isEnabled:enabled isAlarming:alarm named:name belongsToFloor:floorID roomID:roomID];
                
                [rooms addObject:room];
            }
        }       
    }
}

-(IBAction)buttonclick:(id)sender
{
    [self performSegueWithIdentifier:@"goToInformatiepagina" sender:sender];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"goToInformatiepagina"])
    {
        DynamicTabBarViewController* dest = (DynamicTabBarViewController*)segue.destinationViewController;
        [[dataStorage sharedManager]setBuildingId:buildingIdentifier];
        NSString* tmp = [NSString stringWithFormat:@"%d", [sender tag]];
        [[dataStorage sharedManager]setRoomID:tmp];
    }
}

- (IBAction)knopDruk:(id)sender
{
    //selects current elevator button, deselects last one.
    if(laatsteKnop != nil){
        [laatsteKnop setEnabled:true];
    }
    [sender setEnabled:false];
    
    //remove every subview from the mainview, these subviews should be rooms.
    [[self.mainView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //create and add the roombuttons
    NSInteger selectedFloor = [sender tag];
        
        for(Room *roomie in rooms){
            if(roomie.floorID == selectedFloor){
              
                UIButton *roomButton = [UIButton buttonWithType:UIButtonTypeCustom];
                //[roomButton setTitle:roomie.roomName forState:UIControlStateNormal];
                roomButton.frame = roomie.rect;
                roomButton.enabled = roomie.enabled;
                roomButton.alpha = 0.5;
                [roomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [roomButton setTitle:roomie.roomName forState:UIControlStateNormal];
                [roomButton setTag:selectedFloor];
                [[roomButton layer] setBorderWidth:1.0f];
                [[roomButton layer] setBorderColor:[UIColor blackColor].CGColor];
                if(roomie.alarm){
                    [roomButton setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1]];
                    //NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(toggleButtonImage:) userInfo:nil repeats:YES];
                    //[timer start]
                }
                [roomButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
              
                [self.mainView addSubview:roomButton];
                
            }
        }

    
    //Set background of that floor.
    NSString *imageString = [NSString stringWithFormat: @"http://145.48.128.101/images/%d.png", selectedFloor];
    NSURL *url = [NSURL URLWithString: imageString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    [_mainView setImage:image];
    
    laatsteKnop = sender;
}
/*
- (void)toggleButtonImage:(NSTimer*)timer
{
    if(toggle)
    {
        [test setImage:[UIImage imageNamed:@"Button1.png"] forState: UIControlStateNormal];
    }
    else
    {
        [test setImage:[UIImage imageNamed:@"ButtonPressed.png"] forState: UIControlStateNormal];
    }
    toggle = !toggle;
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}
@end
