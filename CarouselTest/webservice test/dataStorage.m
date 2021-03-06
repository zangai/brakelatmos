//
//  dataStorage.m
//  webservice test
//
//  Created by Tjitte de Visscher on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "dataStorage.h"
#import "Building.h"

@implementation dataStorage


@synthesize bImages;
@synthesize buildings;


+ (id)sharedManager {
    static dataStorage *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        bImages = [[NSMutableArray alloc] initWithObjects:nil];
        buildings = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void) initArrayLists:(NSMutableArray *)data
{
 
    for (int i =0; i < [data count]; i++)
    {
        NSDictionary *tempDict = [data objectAtIndex:i];
      //  NSString *bid = [tempDict valueForKey:(@"BuildingID")];
        
        Building* building = [[Building alloc] init];
        building.BuildingID = [tempDict valueForKey:(@"BuildingID")];
        building.BuildingName = [tempDict valueForKey:(@"BuildingName")];
        building.AccessRights = [tempDict valueForKey:(@"AccesRole")];
        
        [buildings addObject:building];
    }
    
}

@end
