//
//  TemperatureWidget.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Widget.h"
#import <QuartzCore/QuartzCore.h>

@interface TemperatureWidget : Widget <CPTPlotDataSource>

@property UIButton *button;
@property CGContextRef context;
@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
