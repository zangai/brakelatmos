//
//  Ipsum.h
//  IpsumTest
//
//  Created by Patrick Decoster on 09-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

typedef void (^WebRequestCallback)(NSString *response);

@interface Ipsum : NSObject

@property (nonatomic, strong) Token * token;
@property (nonatomic, copy) WebRequestCallback callback;

+(Ipsum*) getInstance;

-(id)init:(NSString *)privateKey;

-(BOOL)isAuthenticated;
-(void)authenticateWithUsername:(NSString *)username Password:(NSString *)password;
-(void)getLocations:(WebRequestCallback)completion;

@end
