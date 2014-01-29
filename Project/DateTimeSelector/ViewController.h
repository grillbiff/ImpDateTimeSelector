//
//  ViewController.h
//  DateTimeSelector
//
//  Created by Erik Johansson on 1/9/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImpDateTimeSelector/ImpDateTimeSelectorView.h>

@interface ViewController : UIViewController<ImpDateTimeSelectorDelegate>
{
    NSDateFormatter *_dateFormatter;
    NSDateComponents *_currentDateComps;
    ImpDateTimeSelectorView *_selectorView;
}

@property (weak, nonatomic) IBOutlet ImpDateTimeSelectorPad *yearSelector;
@property (weak, nonatomic) IBOutlet ImpDateTimeSelectorPad *monthSelector;
@property (weak, nonatomic) IBOutlet ImpDateTimeSelectorPad *daySelector;
@property (weak, nonatomic) IBOutlet ImpDateTimeSelectorPad *hourSelector;
@property (weak, nonatomic) IBOutlet ImpDateTimeSelectorPad *minuteSelector;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)onSegmentedControlValueChanged:(id)sender;
@end
