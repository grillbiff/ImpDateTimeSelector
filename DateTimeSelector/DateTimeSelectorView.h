//
//  DateTimeSelectorView.h
//  DateTimeSelector
//
//  Created by Erik Johansson on 29/01/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimeSelectorPad.h"

@interface DateTimeSelectorView : UIView<DateTimeSelectorDelegate>
{
    NSArray *_selectorPads;
}

@property (nonatomic,readwrite) ImpDateTimeType dateTimeTypes;
@property (nonatomic,weak) id<DateTimeSelectorDelegate>delegate;

-(DateTimeSelectorPad *)selectorPadForDateTimeType:(ImpDateTimeType)type;


@end
