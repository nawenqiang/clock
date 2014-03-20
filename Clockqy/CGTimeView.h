//
//  CGTimeView.h
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DDNeedleView : UIView{
    
    float _angle;
    
    float _radius;  //长短
    
    CGPoint _centerCircle;
}

@property (nonatomic,assign) float angle;

@property (nonatomic,assign) CGPoint centerCircle;

@end

@interface DDNeedleHourView : DDNeedleView

@end

@interface DDNeedleMinuteView : DDNeedleView

@end

@interface DDNeedleSecondView : DDNeedleView

@end