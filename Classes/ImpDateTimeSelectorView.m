//
//  DateTimeSelectorView.m
//  DateTimeSelector
//
//  Created by Erik Johansson on 29/01/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import "ImpDateTimeSelectorView.h"

@implementation ImpDateTimeSelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
    
}

-(void)setDateTimeTypes:(ImpDateTimeType *)dateTimeTypes size:(int)size
{
    NSMutableArray *pads = [NSMutableArray array];

    
    for(int i=0;i < size; i++)
    {
        ImpDateTimeType type = dateTimeTypes[i];
        ImpDateTimeSelectorPad *pad = [[ImpDateTimeSelectorPad alloc] init];
        pad.dateTimeType = type;
        pad.delegate = self;
        pad.textLabel.text = [ImpDateTimeSelectorView labelNameFromDateTimeType:type];
        [pads addObject:pad];
        [self addSubview:pad];
    }
    
    // remove any previous pads
    if(_selectorPads)
    {
        for(UIView *pad in _selectorPads)
            [pad removeFromSuperview];
    }
    
    _selectorPads = pads;
    [self setNeedsLayout];
}

-(ImpDateTimeSelectorPad *)selectorPadForDateTimeType:(ImpDateTimeType)type
{
    if(_selectorPads)
    {
        for(ImpDateTimeSelectorPad *pad in _selectorPads)
        {
            if(type == pad.dateTimeType)
                return pad;
        }
    }

    return nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_selectorPads)
    {
        CGFloat padWidth = self.frame.size.width / [_selectorPads count];
        int i = 0;
        for(ImpDateTimeSelectorPad *pad in _selectorPads)
        {
            pad.frame = CGRectMake(i*padWidth , 0, padWidth, self.frame.size.height);
            i++;
        }
    }
}

#pragma mark - DateTimeSelectorPadDelegate

-(void)dateTimeSelectorPad:(ImpDateTimeSelectorPad *)dateTimeSelector onValueChanged:(NSInteger)value
{
    if(_delegate && [_delegate respondsToSelector:@selector(dateTimeSelectorPad:onValueChanged:)])
        [_delegate dateTimeSelectorPad:dateTimeSelector onValueChanged:value];
}

-(void)onShowValueLabel:(ImpDateTimeSelectorPad *)dateTimeSelectorPad
{
    if(_delegate && [_delegate respondsToSelector:@selector(onShowValueLabel:)])
        [_delegate onShowValueLabel:dateTimeSelectorPad];
}

-(void)onHideValueLabel:(ImpDateTimeSelectorPad *)dateTimeSelectorPad
{
    if(_delegate && [_delegate respondsToSelector:@selector(onHideValueLabel:)])
        [_delegate onHideValueLabel:dateTimeSelectorPad];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(NSString *)labelNameFromDateTimeType:(ImpDateTimeType)type
{
    switch (type) {
        case ImpDateTimeTypeYear:
            return @"Year";
        case ImpDateTimeTypeMonth:
            return @"Month";
        case ImpDateTimeTypeDay:
            return @"Day";
        case ImpDateTimeTypeHour:
            return @"Hour";
        case ImpDateTimeTypeMinute:
            return @"Minute";
        case ImpDateTimeTypeSecond:
            return @"Second";
        case ImpDateTimeTypeNoType:
            return nil;
    }
    
    return nil;
}

@end
