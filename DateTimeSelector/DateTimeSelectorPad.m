//
//  DateTimeSelector.m
//  DateTimeSelector
//
//  Created by Erik Johansson on 1/9/14.
//  Copyright (c) 2014 Fatcal. All rights reserved.
//

#import "DateTimeSelectorPad.h"
#import <QuartzCore/QuartzCore.h>

@implementation DateTimeSelectorPad

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setup];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        [self setup];
    }
    return self;
}


-(void)setup
{
    _dateTimeType = ImpDateTimeTypeNoType;
    _step = 1;
    _lowerBound = 0;
    _upperBound = 24;
    _value = (_upperBound - _lowerBound)/2.0;
    _relative = NO;
    _wrapAround = YES;
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.textColor = [UIColor redColor];
    _valueLabel.font = [UIFont boldSystemFontOfSize:18.0];
    _valueLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _valueLabel.layer.borderWidth = 2.0,
    _valueLabel.layer.cornerRadius = 25;
    _valueLabel.layer.masksToBounds = YES;
    _valueLabel.layer.backgroundColor = [[UIColor colorWithWhite:0 alpha:.7] CGColor];
    
    
    _valueLabel.hidden = YES;
    [self addSubview:_valueLabel];
}

-(void)setDateTimeType:(ImpDateTimeType)dateTimeType
{
    _dateTimeType = dateTimeType;
    switch (_dateTimeType) {
        case ImpDateTimeTypeMonth:
            _lowerBound = 1;
            _upperBound = 12;
            break;
        case ImpDateTimeTypeDay:
            _lowerBound = 1;
            _upperBound = 31;
            break;
        case ImpDateTimeTypeHour:
            _lowerBound = 0;
            _upperBound = 24;
            break;
        case ImpDateTimeTypeMinute:
            _lowerBound = 0;
            _upperBound = 59;
            break;
        case ImpDateTimeTypeSecond:
            _lowerBound = 0;
            _upperBound = 59;
            break;
        default:
            NSLog(@"No default value for given ImpDateTimeType (%ld)",dateTimeType);
            break;
    }
}

-(void)showValueLabel
{
    // notify delegate
    if([_delegate respondsToSelector:@selector(onShowValueLabel:)])
       [_delegate onShowValueLabel:self];
    
    if(!_showDefaultValueLabel)
        return;
        
    _valueLabel.hidden = NO;
    
    CATransform3D trans =  CATransform3DIdentity;
    //CATransform3DMakeRotation(M_PI/2.0, 1.0, 0.0, 0.0);
    //trans = CATransform3DTranslate(trans, 0, -25, -25);
    trans = CATransform3DScale(trans, .5, .5, 1.0);
    _valueLabel.layer.transform = trans;
    _valueLabel.alpha = 0.0;
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _valueLabel.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
        _valueLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hideValueLabel
{
    if([_delegate respondsToSelector:@selector(onHideValueLabel:)])
        [_delegate onHideValueLabel:self];
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CATransform3D trans = CATransform3DMakeRotation(M_PI/2.0, 1.0, 0.0, 0.0);
        trans = CATransform3DTranslate(trans, 0, 0, -25);
        _valueLabel.layer.transform = trans;
        _valueLabel.alpha = 0.0;

    } completion:^(BOOL finished) {
        _valueLabel.hidden = YES;
    }];

    
}

-(NSInteger)valueFromPoint:(CGPoint)point
{
    CGFloat p = 1.0 - (point.y / self.frame.size.height);
    NSInteger result = ((_upperBound - _lowerBound) * p + _lowerBound);
    
    return result;
}

-(CGFloat)relativeValueFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGFloat p = (from.y - to.y)  / self.frame.size.height;
    CGFloat result = (_upperBound - _lowerBound) * p;
    return result;
}


-(void)handleTouch:(NSSet *)touches
{
    CGPoint nowPoint = [touches.anyObject locationInView:self];
    CGPoint prevPoint = [touches.anyObject previousLocationInView:self];
    if(!_relative)
        _value = [self valueFromPoint:nowPoint];
    else
        _value += [self relativeValueFromPoint:prevPoint toPoint:nowPoint];

    NSInteger resultValue;
    if(_wrapAround)
        resultValue = ((int)_value % (_upperBound + 1 - _lowerBound)) + _lowerBound;
    else
        resultValue = MAX(_lowerBound, MIN(_upperBound,_value));
    
    // take the step into account
    if(_step > 1)
    {
        resultValue = resultValue - (resultValue % _step);
    }
    
    _valueLabel.text = [NSString stringWithFormat:@"%ld",resultValue];
    _valueLabel.center = CGPointMake(nowPoint.x, nowPoint.y - 80);
    
    if(_delegate && [_delegate respondsToSelector:@selector(dateTimeSelector:onValueChanged:)])
        [_delegate dateTimeSelector:self onValueChanged:(int)resultValue];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //_valueLabel.hidden = NO;
    [self showValueLabel];
    [self handleTouch:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideValueLabel];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideValueLabel];
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
