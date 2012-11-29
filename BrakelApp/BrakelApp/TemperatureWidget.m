//
//  TemperatureWidget.m
//  webservice test
//
//  Created by CHRISTIAAN Rakowski on 11/15/12.
//  Copyright (c) 2012 Luc Rosenbrand. All rights reserved.
//

#import "TemperatureWidget.h"

#define DIVIDER 7

@implementation TemperatureWidget

@synthesize button;
@synthesize context;
@synthesize hostView = hostView_;



#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {

    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.bounds];
    self.hostView.allowPinchScaling = YES;
    [self addSubview:self.hostView];
}

-(void)configureGraph {
    // 1 - Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    // 2 - Set graph title
    NSString *title = @"Showing Temperature";
    graph.title = title;
    // 3 - Create and set text style
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    // 4 - Set padding for plot area
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:30.0f];
    // 5 - Enable user interactions for plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots {
}

-(void)configureAxes {
}

-(id)initWithJson:(NSDictionary*)json
{
    self = [super initWithJson:json];
    
    return self;
}
+(TemperatureWidget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[TemperatureWidget alloc] initWithJson:json];
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"temperature widget is showing now");
    
    NSLog([NSString stringWithFormat:@"Long %f", self.bounds.size.width]);
    [self initPlot];
    [self addSubview:button];
}




#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 0;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    return [NSDecimalNumber zero];
}
@end
