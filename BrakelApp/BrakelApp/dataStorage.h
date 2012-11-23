//
//  dataStorage.h
//  webservice test
//
//  Created by Tjitte de Visscher on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataStorage : NSObject
{
    NSString *someProperty;
}

@property (nonatomic, retain) NSMutableArray *buildings;
@property (nonatomic, retain) NSMutableArray *bImages;
@property (nonatomic, retain) NSString* userToken;
@property (nonatomic, retain) NSString* roomID;

- (void) initArrayLists:(NSMutableArray *)data;
- (void) setUserToken:(NSString *)ut;
- (NSString*) getUserToken;

+ (id)sharedManager;
@end


