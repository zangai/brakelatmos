//
//  TemperatureWidget.h
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "Widget.h"
#import <QuartzCore/QuartzCore.h>
#import "Widget.h"
#import <QuartzCore/QuartzCore.h>
#define graphTitle             "Temperature"
#define yAxisName              "Temp °C"
#define xAxisName               "Time"
#define gemmideldeco2label  "Average:"
#define huidigco2label      "Current:"
#define paddingXleftLabels  25


@interface TemperatureWidget : Widget <CPTPlotDataSource>
{

//Buttons
UIButton *showWeek;
UIButton *showMaand;
UIButton *showJaar;
UIButton *showDag;

//Views
UIView   *bottomView;
UIView   *leftView;
CPTGraphHostingView *graphView;
UIImageView *logo;

//Labels
UILabel *gemmTemp;
UILabel *huidTemp;
UILabel *gemmTempValue;
UILabel *huidigTempValue;
UIColor *iphoneBlue;

NSMutableArray *xAxisValues;

}


//Views
@property (nonatomic, strong) CPTGraphHostingView *graphView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *midBorder;
@property (nonatomic, strong) UIImageView *logo;

//Buttons
@property (nonatomic, strong) UIButton *showWeek;
@property (nonatomic, strong) UIButton *showMaand;
@property (nonatomic, strong) UIButton *showJaar;
@property (nonatomic, strong) UIButton *showDag;

//Labels
@property (nonatomic, strong) UILabel *gemmTemp;
@property (nonatomic, strong) UILabel *huidTemp;
@property (nonatomic, strong) UILabel *gemmTempValue;
@property (nonatomic, strong) UILabel *huidigTempValue;


+(TemperatureWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json;

@end
