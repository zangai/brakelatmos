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
- (void) initArrayLists:(NSMutableArray *)data;


+ (id)sharedManager;
@end


