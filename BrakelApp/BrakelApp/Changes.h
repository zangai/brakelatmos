//
//  Changes.h
//  BrakelApp
//
//  Created by CHRISTIAAN Rakowski on 11/29/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Changes : NSObject

@property (nonatomic) NSInteger GroupID;
@property (nonatomic) NSInteger ChangeValue;
@property (nonatomic) Boolean ChangeStatus;

-(NSString*) toJSONString;

@end
