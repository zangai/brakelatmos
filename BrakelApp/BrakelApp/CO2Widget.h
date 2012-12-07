//
//  CO2Widget.h
//  BrakelApp
//
//  Created by Joost on 06-12-12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "Widget.h"
#import <QuartzCore/QuartzCore.h>
#define graphTitle             "CO2 level"
#define yAxisName              "CO2 percentage"
#define xAxisName               "Time"
#define gemmideldeco2label  "Average:"
#define huidigco2label      "Current:"
#define paddingXleftLabels  25


@interface CO2Widget : Widget <CPTPlotDataSource>
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
    UILabel *gemmCO2;
    UILabel *huidCO2;
    UILabel *gemmCO2Value;
    UILabel *huidigCO2Value;
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
@property (nonatomic, strong) UILabel *gemmCO2;
@property (nonatomic, strong) UILabel *huidCO2;
@property (nonatomic, strong) UILabel *gemmCO2Value;
@property (nonatomic, strong) UILabel *huidigCO2Value;

+(CO2Widget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json;

@end
