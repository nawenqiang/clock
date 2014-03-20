//
//  DDNeedleView.h
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNeedleView : UIView{
    
    float _angle;
    float _tempangle;
    
    float _shortradius;  //半径
    float _lengthradius;  //外环长度
    
    CGPoint _centerCircle;
}

@property (nonatomic,assign) float angle;
@property (nonatomic,assign) CGPoint centerCircle;

@end

@interface DDNeedleHourView : DDNeedleView

- (void)setAlpha:(float)getlength;

@end

@interface DDNeedleMinuteView : DDNeedleView

- (void)setAlpha:(float)getlength;

@end

@interface DDNeedleSecondView : DDNeedleView

- (void)setAlpha:(float)getlength;

@end