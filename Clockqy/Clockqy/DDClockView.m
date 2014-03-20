//
//  DDClockView.m
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "DDClockView.h"


#import "DDNeedleView.h"

@interface DDClockView(){
    
    NSTimer *_timer;
    
    NSDateComponents *_comps;
}

-(void)startTimer;

-(void)updatetime3;

@end

@implementation DDClockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[UIColor clearColor];
        //时针
        _viewOfHourNeedle =[[DDNeedleHourView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_viewOfHourNeedle];
        //分针
        _viewOfMinuteNeedle =[[DDNeedleMinuteView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_viewOfMinuteNeedle];
        //秒针
        _viewOfSecondNeedle =[[DDNeedleSecondView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_viewOfSecondNeedle];
        [self updatetime3];
        [self startTimer];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


-(void)startTimer{
    
    _timer =[NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updatetime3)
                                           userInfo:nil
                                            repeats:YES];
}



-(void)updatetime3{
    
    NSDate *currentDate =[NSDate date];
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSSecondCalendarUnit |NSMinuteCalendarUnit | NSHourCalendarUnit;
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:currentDate];
    
	NSInteger seconds = [comps second];
    NSInteger minute =[comps minute];
    NSInteger hour =[comps hour];
    
    //计算， 保证360度
    float angleOfSecond =seconds * 6.0f;
    
    float angleOfMinute =(minute +seconds/60.0f ) *6.0f;
    
    float angleOfHour = (hour%12)*30.0f + ((minute +seconds/60.0f )/60.0f)*30.0f;
    
    [_viewOfSecondNeedle setAngle:angleOfSecond];
    
    [_viewOfMinuteNeedle setAngle:angleOfMinute];
    
    [_viewOfHourNeedle setAngle:angleOfHour];
}

@end
