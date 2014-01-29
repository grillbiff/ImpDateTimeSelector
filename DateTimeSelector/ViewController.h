//
//  ViewController.h
//  DateTimeSelector
//
//  Created by Erik Johansson on 1/9/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimeSelectorPad.h"

@interface ViewController : UIViewController<DateTimeSelectorDelegate>
{
    NSDateFormatter *_dateFormatter;
    NSDateComponents *_currentDateComps;
}

@property (weak, nonatomic) IBOutlet DateTimeSelectorPad *yearSelector;
@property (weak, nonatomic) IBOutlet DateTimeSelectorPad *monthSelector;
@property (weak, nonatomic) IBOutlet DateTimeSelectorPad *daySelector;
@property (weak, nonatomic) IBOutlet DateTimeSelectorPad *hourSelector;
@property (weak, nonatomic) IBOutlet DateTimeSelectorPad *minuteSelector;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)onSegmentedControlValueChanged:(id)sender;
@end
