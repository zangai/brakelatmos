//
//  Building.h
//  webservice test
//
//  Created by Tjitte de Visscher on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject

@property (nonatomic, strong) NSString* BuildingID;
@property (nonatomic, strong) NSString* BuildingName;
@property (nonatomic, strong) NSString* AccessRights;

-(UIImage*) getImage;

@end
