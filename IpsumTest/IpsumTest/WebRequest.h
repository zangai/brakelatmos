//
//  WebRequest.h
//  IpsumTest
//
//  Created by Patrick Decoster on 12-10-12.
//  Copyright (c) 2012 Avans Hogeschool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebRequest : NSObject
-(void)doPost:(NSString*)command
                   data:(NSString*)parameters
               delegate:(id)delegate
               handleBy:(SEL)handler;
@end
