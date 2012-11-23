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
    NSMutableArray *rooms;
    NSMutableData *receivedData;
}

@synthesize buildingIdentifier;

UIButton* laatsteKnop;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Testdata
    
    rooms = [[NSMutableArray alloc]init];
    Room *room = [Room alloc];
    Room *room2 = [Room alloc];
    room = [room initWithRect:CGRectMake(10, 50, 100, 100) isEnabled:true isAlarming:false named:@"Room1"];
    room2 = [room2 initWithRect:CGRectMake(120, 160, 100, 100) isEnabled:true isAlarming:false named:@"Room2"];
    [rooms addObject:room];
    [rooms addObject:room2];
    UIImage *image = [UIImage imageNamed: @"gebouw1.jpeg"];
    [_viewBackground setImage:image];
    
    //End Testdata
    
    int knopX = 40;
    int knopY = 20;
    NSInteger verdieping = 45;
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

    
    //_testlabel.text = @"test";
    
    
    //[_liftPlaatje1 setEnabled:NO]; // To toggle enabled / disabled
    
    //UIButton *mijnknop = [UIButton buttonWithType:UIButtonTypeCustom];
    for (NSInteger x = 1; x <= verdieping; x++) {
        //[_liftPlaatje1 setEnabled:NO];
        
        UIButton *liftKnop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [liftKnop setTitle:[NSString stringWithFormat:@"%d", x] forState:UIControlStateNormal];
        
        liftKnop.frame = CGRectMake(knopX, knopY, 70, 70);
        liftKnop.tag = x;
        //CGRectMake(20, 20, 20, 44); // position in the parent view and set the size of the button
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"blue"]  forState:UIControlStateNormal];
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateHighlighted];
        [liftKnop setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateDisabled];
        //liftKnop.titleLabel.font = [UIFont systemFontOfSize:30];
        [liftKnop.titleLabel setFont:[UIFont  fontWithName:@"Helvetica-Bold" size:30.0]];
        [liftKnop addTarget:self action:@selector(knopDruk:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        [liftKnop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [liftKnop setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_deuiviewnav addSubview:liftKnop];
        if(x % 2){
            knopX = knopX +110;
        } else {
            knopY = knopY +90;
            knopX = knopX -110;
        }
    }
    _deuiviewnav.frame = CGRectMake(0, 0, 250, knopY + 80);
    [self parseRoom];
}

-(void)callHandler:(id)caller response:(NSData *) response {
    [receivedData appendData:response];
    if(receivedData != nil){
        //Parse JSON
        NSError *myError = nil;
        NSDictionary *floors = [NSJSONSerialization JSONObjectWithData:self->receivedData options:NSJSONReadingMutableLeaves error:&myError];
    }
}

- (void)parseRoom
{
    for(Room *roomie in rooms){
        UIButton *roomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [roomButton setTitle:roomie.roomID forState:UIControlStateNormal];
        roomButton.frame = roomie.rect;
        roomButton.enabled = roomie.enabled;
        roomButton.alpha = 0.5;
        [[roomButton layer] setBorderWidth:1.0f];
        [[roomButton layer] setBorderColor:[UIColor blackColor].CGColor];
        [roomButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:roomButton];
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
        [[dataStorage sharedManager]setRoomID:@""];
    }
}

- (IBAction)knopDruk:(id)sender
{
    if(laatsteKnop != nil){
        [laatsteKnop setEnabled:true];
    }
    [sender setEnabled:false];


    UIImage *image = [UIImage imageNamed: @"plattegrond1.gif"];  //hier komt het plaatje van de desbetreffende verdieping
    [_viewBackground setImage:image];
    
    laatsteKnop = sender;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

@end
