//
//  Building.m
//  webservice test
//
//  Created by Tjitte de Visscher on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize BuildingID, BuildingName, AccessRights;

-(UIImage*) getImage
{
    NSString *imageString = [NSString stringWithFormat: @"http://145.48.128.101/images/%@.png", BuildingID];
    //NSString *imageString = [NSString stringWithString: (@"http://145.48.128.101/images/1.png")];
    NSURL *url = [NSURL URLWithString: imageString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    return image;
}

-(NSString*) getBuildingID
{
    return BuildingID;
}

@end
