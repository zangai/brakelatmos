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

- (void) initArrayLists:(NSMutableArray *)data;
- (void) setUserToken:(NSString *)userToken;
- (NSString*) getUserToken;

+ (id)sharedManager;
@end


