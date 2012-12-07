//
//  WindWidget.h
//  BrakelApp
//
//  Created by wlmligte on 12/6/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Widget.h"

@interface WindWidget :Widget

+(WindWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json;
@end
