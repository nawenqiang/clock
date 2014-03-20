//
//  CGClockView.h
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//
#import <UIKit/UIKit.h>

@class DDDialView;
@class DDNeedleHourView;
@class DDNeedleMinuteView;
@class DDNeedleSecondView;

@interface DDClockView : UIView{
    
    DDDialView *_viewOfDial;
    
    DDNeedleHourView *_viewOfHourNeedle;
    
    DDNeedleMinuteView *_viewOfMinuteNeedle;
    
    DDNeedleSecondView *_viewOfSecondNeedle;
}

@end
