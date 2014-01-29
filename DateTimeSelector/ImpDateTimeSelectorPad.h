//
//  DateTimeSelector.h
//  DateTimeSelector
//
//  Created by Erik Johansson on 1/9/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, ImpDateTimeType) {
    ImpDateTimeTypeNoType = 0,
    ImpDateTimeTypeYear = 1 << 0,
    ImpDateTimeTypeMonth = 1 << 1,
    ImpDateTimeTypeDay = 1 << 2,
    ImpDateTimeTypeHour = 1 << 3,
    ImpDateTimeTypeMinute = 1 << 4,
    ImpDateTimeTypeSecond = 1 << 5
};

@class ImpDateTimeSelectorPad;

@protocol DateTimeSelectorDelegate <NSObject>
@optional
-(void)dateTimeSelectorPad:(ImpDateTimeSelectorPad *)dateTimeSelectorPad onValueChanged:(NSInteger)value;
-(void)onShowValueLabel:(ImpDateTimeSelectorPad *)dateTimeSelectorPad;
-(void)onHideValueLabel:(ImpDateTimeSelectorPad *)dateTimeSelectorPad;
@end

@interface ImpDateTimeSelectorPad : UIView
{
    UILabel *_valueLabel;
}
@property (nonatomic,readwrite) NSInteger lowerBound;
@property (nonatomic,readwrite) NSInteger upperBound;
@property (nonatomic,readwrite) NSInteger step;
@property (nonatomic,readwrite) BOOL relative;
@property (nonatomic,weak) id<DateTimeSelectorDelegate> delegate;
@property (nonatomic,readwrite) CGFloat value;
@property (nonatomic,readwrite) BOOL wrapAround;
@property (nonatomic,readwrite) BOOL showDefaultValueLabel;
@property (nonatomic,readwrite) ImpDateTimeType dateTimeType;
@end
