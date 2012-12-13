//
//  WindWidget.h
//  BrakelApp
//
//  Created by Joost on 06-12-12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "Widget.h"
#import <QuartzCore/QuartzCore.h>
#define graphTitle             "Wind level"
#define yAxisName              "Wind percentage"
#define xAxisName               "Time"
#define gemmideldeWindlabel  "windsnelheid"
#define huidigWindlabel      "windrichting:"
#define paddingXleftLabels  25


@interface WindWidget : Widget <CPTPlotDataSource>
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
    UIView *windVaan;
    UIImageView *windvaanlogo;
    
    //Labels
    UILabel *gemmWind;
    UILabel *huidWind;
    UILabel *gemmWindValue;
    UILabel *huidigWindValue;
    UIColor *iphoneBlue;
    
    NSMutableArray *xAxisValues;
    
}


//Views
@property (nonatomic, strong) CPTGraphHostingView *graphView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *midBorder;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIView *windVaan;
@property (nonatomic, strong) UIImageView *windvaanlogo;

//Buttons
@property (nonatomic, strong) UIButton *showWeek;
@property (nonatomic, strong) UIButton *showMaand;
@property (nonatomic, strong) UIButton *showJaar;
@property (nonatomic, strong) UIButton *showDag;

//Labels
@property (nonatomic, strong) UILabel *gemmWind;
@property (nonatomic, strong) UILabel *huidWind;
@property (nonatomic, strong) UILabel *gemmWindValue;
@property (nonatomic, strong) UILabel *huidigWindValue;

+(WindWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json;

@end
