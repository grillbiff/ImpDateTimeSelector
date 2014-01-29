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

-(void)setDateTimeTypes:(ImpDateTimeType)dateTimeTypes
{
    NSMutableArray *pads = [NSMutableArray array];
    
    ImpDateTimeType types[] = {ImpDateTimeTypeYear,ImpDateTimeTypeMonth,ImpDateTimeTypeDay,ImpDateTimeTypeHour,ImpDateTimeTypeMinute,ImpDateTimeTypeSecond};
    
    for(int i=0;i<sizeof(types) / sizeof(ImpDateTimeType); i++)
    {
        ImpDateTimeType type = types[i];
        ImpDateTimeSelectorPad *pad = [[ImpDateTimeSelectorPad alloc] init];
        pad.dateTimeType = type;
        [pads addObject:pad];
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

@end
