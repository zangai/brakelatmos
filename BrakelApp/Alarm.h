//
//  Alarm.h
//  BrakelApp
//
//  Created by wlmligte on 11/22/12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Alarm : UIView

- (void)drawOverlay:(CGRect)rect view:(UIView*)overlayView;
- (id)initWithFrame:(CGRect)frame : (UIView*) viewa;

@property UIView *viewForOverlay;

@end
