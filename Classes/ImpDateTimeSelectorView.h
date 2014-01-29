//
//  DateTimeSelectorView.h
//  DateTimeSelector
//
//  Created by Erik Johansson on 29/01/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImpDateTimeSelectorPad.h"

@interface ImpDateTimeSelectorView : UIView<ImpDateTimeSelectorDelegate>
{
}

@property (nonatomic,readwrite) ImpDateTimeType dateTimeTypes;
@property (nonatomic,weak) id<ImpDateTimeSelectorDelegate>delegate;
@property (nonatomic,readonly) NSArray *selectorPads;

-(ImpDateTimeSelectorPad *)selectorPadForDateTimeType:(ImpDateTimeType)type;


@end
