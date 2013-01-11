//
//  CO2Widget.m
//  BrakelApp
//
//  Created by Joost on 06-12-12.
//  Copyright (c) 2012 Brakel Atmos. All rights reserved.
//

#import "CO2Widget.h"




@implementation CO2Widget

@synthesize showJaar;
@synthesize showMaand;
@synthesize showWeek;
@synthesize showDag;

@synthesize bottomView;
@synthesize leftView;
@synthesize graphView;
@synthesize midBorder;

@synthesize gemmCO2;
@synthesize huidCO2;
@synthesize gemmCO2Value;
@synthesize huidigCO2Value;

@synthesize logo;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        xAxisValues = [[NSMutableArray alloc]initWithObjects: @"1",nil];
        iphoneBlue =
        [UIColor colorWithRed:0.121653f green:0.558395f blue:0.837748f alpha:1];
        self.layer.cornerRadius = 25;
        self.layer.masksToBounds = YES;
        [self initPlot];
        [self addButtons];
        [self addleftLabels];
        midBorder = [[UIView alloc]initWithFrame:CGRectMake(leftView.bounds.size.width-5, 0, 5, self.frame.size.height)];
        [midBorder setBackgroundColor:[UIColor blackColor]];
        [self addSubview:midBorder];
        
    
    }
    return self;
}

-(id)initWithJson:(NSDictionary *)json
{
    self = [super initWithJson:json];
    xAxisValues = [[NSMutableArray alloc]initWithObjects: @"1",nil];
    iphoneBlue =
    [UIColor colorWithRed:0.121653f green:0.558395f blue:0.837748f alpha:1];
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = YES;
    [self initPlot];
    [self addButtons];
    [self addleftLabels];
    midBorder = [[UIView alloc]initWithFrame:CGRectMake(leftView.bounds.size.width-5, 0, 5, self.frame.size.height)];
    [midBorder setBackgroundColor:[UIColor blackColor]];
    [self addSubview:midBorder];

    return self;
}

+(CO2Widget*)makeWidgetWithType:(NSString*)type jsonData:(NSDictionary*)json
{
    return [[CO2Widget alloc] initWithJson:json];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)addleftLabels
{  

    
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4, self.frame.size.height)];
    
    int labelWidth = leftView.frame.size.width-(paddingXleftLabels+5);
    int labelHeight = (leftView.frame.size.height/6);
    
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(((leftView.bounds.size.width/2)-(leftView.bounds.size.height/6)/2), leftView.bounds.origin.y, leftView.bounds.size.height/6, leftView.bounds.size.height/6)];
    UIImage *myImage = [UIImage imageNamed:@"CO2.png"];
    [logo setImage:myImage];
    logo.tag = 111;

    
    [leftView setBackgroundColor:iphoneBlue];
    self.gemmCO2 = [[UILabel alloc]initWithFrame:CGRectMake(
                                                            leftView.bounds.origin.x+10,
                                                            ((leftView.bounds.size.height- leftView.bounds.origin.y)/6)*2, labelWidth,labelHeight)];

    self.gemmCO2Value = [[UILabel alloc]initWithFrame:CGRectMake(leftView.bounds.origin.x+paddingXleftLabels,
                                                                 (((leftView.bounds.size.height- leftView.bounds.origin.y)/6)*3), labelWidth, labelHeight)];
    self.gemmCO2Value.tag = 1;
    self.huidCO2 =  [[UILabel alloc]initWithFrame:CGRectMake(leftView.bounds.origin.x+10,
                                                            (((leftView.bounds.size.height- leftView.bounds.origin.y)/6)*4), labelWidth, labelHeight)];
    self.huidigCO2Value =  [[UILabel alloc]initWithFrame:CGRectMake(leftView.bounds.origin.x+paddingXleftLabels,
                                                             (((leftView.bounds.size.height- leftView.bounds.origin.y)/6)*5), labelWidth, labelHeight)];
    
    huidigCO2Value.tag = 3;
    gemmCO2.text = @gemmideldeco2label;
    huidCO2.text = @huidigco2label;
    huidigCO2Value.text = [NSString stringWithFormat:@"%@ %@",[self getCurrentCO2Val], @"%"];
    gemmCO2Value.text = [NSString stringWithFormat:@"%@ %@",[self getAverageCO2], @"%"];

    [self.leftView addSubview:gemmCO2Value];
    [self.leftView addSubview:huidCO2];
    [self.leftView addSubview:gemmCO2];
    [self.leftView addSubview:huidigCO2Value];
    for (UILabel *label in self.leftView.subviews) {
        [self transformLabelforLeft:label:label.tag];
    }
        [self.leftView addSubview:logo];
    [self addSubview:leftView];
}
-(void)transformLabelforLeft:(UILabel*)label : (int)sender
{

    [label setBackgroundColor:leftView.backgroundColor];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
    if(sender % 2 == 1)
    {
        UIFont * font = [UIFont fontWithName:@"Helvetica-Bold"
                                        size:30];
        [label setFont: font];
    }
    [label setAdjustsFontSizeToFitWidth:YES];
    
}

#pragma mark - currentCO2

-(NSString*)getCurrentCO2Val
{
    //get current CO2 from database
    NSString* currentString = @"0";
    return currentString;
}

#pragma mark - average co2
-(NSString*)getAverageCO2
{
    NSString* currentString = @"0";
    return currentString;
}

-(void)addButtons
{
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width/4), 0, (self.frame.size.width/4)*3, (self.frame.size.height/6))];
    showJaar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showJaar.tag = 1;
    [showJaar addTarget:self
                 action:@selector(changeGraph:)
     forControlEvents:UIControlEventTouchUpInside];
    [showJaar setTitle:@"Year" forState:UIControlStateNormal];
    showJaar.frame = CGRectMake(bottomView.bounds.origin.x, bottomView.bounds.origin.y, bottomView.bounds.size.width/4, bottomView.bounds.size.height);
    //[self styleButton:showJaar];
    showMaand = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showMaand addTarget:self
                  action:@selector(changeGraph:)
       forControlEvents:UIControlEventTouchUpInside];
    [showMaand setTitle:@"Month" forState:UIControlStateNormal];
    showMaand.frame = CGRectMake((bottomView.bounds.size.width/4), bottomView.bounds.origin.y, bottomView.bounds.size.width/4, bottomView.bounds.size.height);
    showMaand.tag = 2;
    showWeek = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [showWeek addTarget:self
                action:@selector(changeGraph:)
        forControlEvents:UIControlEventTouchUpInside];
    [showWeek setTitle:@"Week" forState:UIControlStateNormal];
    showWeek.frame = CGRectMake(((bottomView.bounds.size.width/4)*2), bottomView.bounds.origin.y, bottomView.bounds.size.width/4, bottomView.bounds.size.height);
    showWeek.tag = 3;
    showDag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showDag addTarget:self
                 action:@selector(changeGraph:)
       forControlEvents:UIControlEventTouchUpInside];
    [showDag setTitle:@"Day" forState:UIControlStateNormal];
    showDag.frame = CGRectMake(((bottomView.bounds.size.width/4)*3), bottomView.bounds.origin.y, bottomView.bounds.size.width/4, bottomView.bounds.size.height);
    showDag.tag = 4;
    //self.showMaand = [[UIButton alloc]initWithFrame:CGRectMake((bottomView.bounds.size.width/3), bottomView.bounds.origin.y, bottomView.bounds.size.width/3, bottomView.bounds.size.height)]
    [bottomView addSubview:showJaar];
    [bottomView addSubview:showDag];
    [bottomView addSubview:showMaand];
    [bottomView addSubview:showWeek];
    [bottomView setBackgroundColor:iphoneBlue];
    [self addSubview:bottomView];  
}

-(void)changeGraph:(id) sender
{
    UIButton *clicked = (UIButton *) sender;
    NSLog(@"%d",clicked.tag);//check welke knop is ingedrukt
    NSInteger times = 0;
    NSInteger multiplier;
    NSDateFormatter *datum = [[NSDateFormatter alloc] init];
    NSDate * aDate = [NSDate date];
    [xAxisValues removeAllObjects];
    switch(clicked.tag)
    {
        case 1:
        {
            times = 13;
            multiplier = 60*60*24*7*4;
            [datum setDateFormat:@"MM" ];       
            break;
        }
        case 2:
        {
            times = 5;
            multiplier = 60*60*24*7;
            [datum setDateFormat:@"MM/ww" ]; 
            break;
        }
        case 3:
        {
            times = 8;
            multiplier = 60*60*24;
            [datum setDateFormat:@"MM/dd" ];            
            break;
            
           
        }
          case 4:
        {
            times = 25;
            multiplier = 60*60;
            [datum setDateFormat:@"HH" ];
            break;
        }
    }
    

    for(int i = 0; i < times; i++)
    {
        NSDate *temp = [aDate dateByAddingTimeInterval:-(multiplier*(i))];
        NSString *toAdd = [datum stringFromDate:temp];
        [xAxisValues addObject:toAdd];
    }
    xAxisValues = [[xAxisValues reverseObjectEnumerator] allObjects];
[self initPlot];
}

-(void)fillXAxis:(NSString*)interval
{

  
    
    
    
    
}

-(void)styleButton:(UIButton*)button2style
{
    [button2style setBackgroundColor:[UIColor blueColor]];
}



#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
    
    self.graphView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:CGRectMake((self.frame.size.width/4), (self.frame.size.height/6), (self.frame.size.width/4)*3, (self.frame.size.height/6)*5)];
    self.graphView.allowPinchScaling = YES;
    [self addSubview:self.graphView];
}

-(void)configureGraph {
    // 1 - Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.graphView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTSlateTheme]];
    self.graphView.hostedGraph = graph;
    // 2 - Set graph title
    NSString *title = @graphTitle;
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
    [graph.plotAreaFrame setPaddingBottom:0.0f];
    // 5 - Enable user interactions for plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots
{
    // 1 - Get graph and plot space
    CPTGraph *graph = self.graphView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    // 2 - Create the three plots
    CPTScatterPlot *tempPlot = [[CPTScatterPlot alloc] init];
    tempPlot.dataSource = self;
    
    CPTColor *tempPlotColor = [CPTColor redColor];
    [graph addPlot:tempPlot toPlotSpace:plotSpace];
    // 3 - Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:tempPlot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    CPTMutableLineStyle *tempStyle = [CPTMutableLineStyle lineStyle];
    tempStyle.lineColor = tempPlotColor;
    CPTPlotSymbol *tempSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    tempSymbol.fill = [CPTFill fillWithColor:tempPlotColor];
    tempSymbol.lineStyle = tempStyle;
    tempSymbol.size = CGSizeMake(6.0f, 6.0f);
    tempPlot.plotSymbol = tempSymbol;
}

-(NSArray*)yAxisDummy
{
    NSArray *yup= [NSArray arrayWithObjects:
                   @"0", @"0", @"0", @"0", @"0", @"0",@"0",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"1",@"0",@"0"@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",nil];
    
    //yup = [[yup reverseObjectEnumerator]allObjects];
    return yup;
}

-(void)configureAxes
{
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.graphView.hostedGraph.axisSet;
    // 3 - Configure x-axis
    CPTAxis *x = axisSet.xAxis;
    x.title = @xAxisName;
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 0.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    CGFloat dateCount = xAxisValues.count;
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
    NSInteger i = 0;
    for (NSString *date in xAxisValues) {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date.description  textStyle:x.labelTextStyle];
        CGFloat location = i++;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    // 4 - Configure y-axis
    CPTAxis *y = axisSet.yAxis;
    y.title = @yAxisName;
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -40.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    NSInteger majorIncrement = 4;
    NSInteger minorIncrement = 2;
    CGFloat yMax = 40.0f;  // should determine dynamically based on max price
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        } else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    y.axisLabels = yLabels;
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
    
}




#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return xAxisValues.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    NSInteger valueCount = xAxisValues.count;
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithUnsignedInteger:index];
            }
            break;
            
        case CPTScatterPlotFieldY:
            return [[self yAxisDummy] objectAtIndex:index];
            break;
    }
    return [NSDecimalNumber zero];
}


@end
