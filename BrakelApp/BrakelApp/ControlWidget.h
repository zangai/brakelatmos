//
//  ControlWidget.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/29/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Widget.h"

@interface ControlWidget : Widget

+(ControlWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json;

- (IBAction)queueForChange:(id)sender;
- (IBAction)makeChanges:(id)sender;

@end
