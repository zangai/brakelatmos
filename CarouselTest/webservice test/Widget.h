//
//  Widget.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/9/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Widget : NSObject

@property (nonatomic) NSUInteger WidgetId;
@property (nonatomic, strong) NSString* Title;
@property (nonatomic, strong) NSString* Description;

@end
