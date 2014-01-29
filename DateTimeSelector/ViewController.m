//
//  ViewController.m
//  DateTimeSelector
//
//  Created by Erik Johansson on 1/9/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _yearSelector.delegate = self;
    _yearSelector.lowerBound = 2012;
    _yearSelector.upperBound = 2020;
    _yearSelector.showDefaultValueLabel = YES;
    
    _monthSelector.delegate = self;
    _monthSelector.lowerBound = 1;
    _monthSelector.upperBound = 12;
    _monthSelector.showDefaultValueLabel = YES;
    
    _daySelector.delegate = self;
    _daySelector.lowerBound = 1;
    _daySelector.upperBound = 31;
    _daySelector.showDefaultValueLabel = YES;
    
    _hourSelector.delegate = self;
    _hourSelector.lowerBound = 0;
    _hourSelector.upperBound = 24;
    _hourSelector.showDefaultValueLabel = YES;

    _minuteSelector.delegate = self;
    _minuteSelector.lowerBound = 0;
    _minuteSelector.upperBound = 60;
    _minuteSelector.step = 5;
    _minuteSelector.showDefaultValueLabel = YES;
    
    _dateFormatter = [[NSDateFormatter alloc] init];
 //   _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
 //   _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    _dateFormatter.dateFormat = @"d MMMM yyyy, hh:mm a";
    
    _segmentedControl.selectedSegmentIndex = 0;
    [self setRelativeMode:NO];
    
    _currentDateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    [self updateDateTimeLabel];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat delay = 0.0;
    for(UIView *view in @[_daySelector,_monthSelector,_yearSelector,_hourSelector,_minuteSelector])
    {
        CATransform3D trans = CATransform3DMakeRotation(M_PI/2.0, 1.0, 0.0, 0.0);
        trans = CATransform3DTranslate(trans, 0, 0, -64);
        view.layer.transform = trans;
        view.alpha = 0.0;
        
        [UIView animateWithDuration:.6 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
            view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
        
        delay += .1;
    }
    
}

-(void)setRelativeMode:(BOOL)isRelative
{
    _yearSelector.relative = isRelative;
    _yearSelector.wrapAround = isRelative;
    
    _monthSelector.relative = isRelative;
    _monthSelector.wrapAround = isRelative;
    
    _daySelector.relative = isRelative;
    _daySelector.wrapAround = isRelative;
    
    _hourSelector.relative = isRelative;
    _hourSelector.wrapAround = isRelative;

    _minuteSelector.relative = isRelative;
    _minuteSelector.wrapAround = isRelative;
}

-(void)updateDateTimeLabel
{
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:_currentDateComps];
    _dateTimeLabel.text = [_dateFormatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DateTimeSelectorDelegate

-(void)dateTimeSelector:(DateTimeSelectorPad *)dateTimeSelector onValueChanged:(NSInteger)value
{
    if(dateTimeSelector == _yearSelector)
        _currentDateComps.year = value;
    else if(dateTimeSelector == _monthSelector)
        _currentDateComps.month = value;
    else if(dateTimeSelector == _daySelector)
        _currentDateComps.day = value;
    else if(dateTimeSelector == _hourSelector)
        _currentDateComps.hour = value;
    else if(dateTimeSelector == _minuteSelector)
        _currentDateComps.minute = value;
    
    [self updateDateTimeLabel];
}

- (IBAction)onSegmentedControlValueChanged:(id)sender
{
    [self setRelativeMode:(_segmentedControl.selectedSegmentIndex == 1)];
}
@end
