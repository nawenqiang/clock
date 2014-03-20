//
//  DDNeedleView.m
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "DDNeedleView.h"

#ifndef TransformRadian
#define TransformRadian(angle) (angle) *M_PI/180.0f
#endif

@implementation DDNeedleView

@synthesize angle =_angle;

@synthesize centerCircle =_centerCircle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _centerCircle =CGPointMake(frame.size.width/2, frame.size.height/2);
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

-(void)setAngle:(float)angle{
    
    _angle =angle;
    
    [self setNeedsDisplay];
}

@end


#pragma -mark----  hour
@implementation DDNeedleHourView

-(id)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        
        _lengthradius =116.0f;
        _shortradius = 106.0f;
        
        _angle =0.0f;
        _tempangle = 0.0f;
        
        self.backgroundColor =[UIColor clearColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    //标记位
    CGContextRef hc = UIGraphicsGetCurrentContext();
    CGMutablePathRef pathh = CGPathCreateMutable();
    CGPoint _p1 = CGPointMake(_centerCircle.x + _lengthradius * sinf(TransformRadian(_angle)), _centerCircle.y - _lengthradius * cosf(TransformRadian(_angle)));
    CGPoint _p2 = CGPointMake(_centerCircle.x + _shortradius * sinf(TransformRadian(_angle)), _centerCircle.y - _shortradius * cosf(TransformRadian(_angle)));
    CGPathMoveToPoint(pathh, NULL, _p1.x, _p1.y);
    CGPathAddLineToPoint(pathh, NULL, _p2.x, _p2.y);
    CGContextAddPath(hc, pathh);
    CGContextSetStrokeColorWithColor(hc, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
    CGContextSetLineWidth(hc, 4.0);
    CGContextDrawPath(hc, kCGPathFillStroke);
    
    [self setAlpha:60];
}

- (void)setAlpha:(float)getlength {
    if (_angle >= 0 && _angle <= getlength) {
        _tempangle = _angle + 360 - getlength;
    } else {
        _tempangle = _angle - getlength;
    }
    
    //炫酷拉伸
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_centerCircle.x, _centerCircle.y);
    CGPathAddRelativeArc(path, &transform, 0, 0, _lengthradius, TransformRadian(_tempangle) -(M_PI / 2), TransformRadian(getlength));
    CGPathAddRelativeArc(path, &transform, 0, 0, _shortradius, TransformRadian(_angle) - (M_PI / 2), -TransformRadian(getlength));
    CGContextAddPath(gc, path);
    CGContextSetLineWidth(gc, 0.1);
    float tempalpha = _angle / 360;
    int red = (int)_angle % 254;
    CGContextSetFillColorWithColor(gc, [[UIColor colorWithRed:red green:(254 - red) blue:0 alpha:tempalpha] CGColor]);
    CGContextDrawPath(gc, kCGPathFillStroke);
}

@end


#pragma -mark --- minute
@implementation DDNeedleMinuteView

-(id)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        _lengthradius =128.0f;
        _shortradius = 118.0f;
        
        _angle =0.0f;
        _tempangle = 0.0f;
        
        self.backgroundColor =[UIColor clearColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    //标记位
    CGContextRef mc = UIGraphicsGetCurrentContext();
    CGMutablePathRef pathm = CGPathCreateMutable();
    CGPoint _p1 = CGPointMake(_centerCircle.x + _lengthradius * sinf(TransformRadian(_angle)), _centerCircle.y - _lengthradius * cosf(TransformRadian(_angle)));
    CGPoint _p2 = CGPointMake(_centerCircle.x + _shortradius * sinf(TransformRadian(_angle)), _centerCircle.y - _shortradius * cosf(TransformRadian(_angle)));
    CGPathMoveToPoint(pathm, NULL, _p1.x, _p1.y);
    CGPathAddLineToPoint(pathm, NULL, _p2.x, _p2.y);
    CGContextAddPath(mc, pathm);
    CGContextSetStrokeColorWithColor(mc, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor]);
    CGContextSetLineWidth(mc, 4.0);
    CGContextDrawPath(mc, kCGPathFillStroke);
    
    [self setAlpha:120];
}

- (void)setAlpha:(float)getlength {
    if (_angle >= 0 && _angle <= getlength) {
        _tempangle = _angle + 360 - getlength;
    } else {
        _tempangle = _angle - getlength;
    }
    
    //炫酷拉伸
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_centerCircle.x, _centerCircle.y);
    CGPathAddRelativeArc(path, &transform, 0, 0, _lengthradius, TransformRadian(_tempangle) -(M_PI / 2), TransformRadian(getlength));
    CGPathAddRelativeArc(path, &transform, 0, 0, _shortradius, TransformRadian(_angle) - (M_PI / 2), -TransformRadian(getlength));
    CGContextAddPath(gc, path);
    CGContextSetLineWidth(gc, 0.1);
    float tempalpha = (float)_angle / 360;
    int green = (int)_angle % 254;
    CGContextSetFillColorWithColor(gc, [[UIColor colorWithRed:0 green:green blue:(254 - green) alpha:tempalpha] CGColor]);
    CGContextDrawPath(gc, kCGPathFillStroke);
}

@end

#pragma -mark  -- second
@implementation DDNeedleSecondView

-(id)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        _lengthradius =140.0f;
        _shortradius = 130.0f;
        
        _angle =0.0f;
        
        self.backgroundColor =[UIColor clearColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    //画标记
    CGContextRef sc = UIGraphicsGetCurrentContext();
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPoint _p1 = CGPointMake(_centerCircle.x +  _lengthradius * sinf(TransformRadian(_angle)), _centerCircle.y - _lengthradius * cosf(TransformRadian(_angle)));
    CGPoint _p2 = CGPointMake(_centerCircle.x + _shortradius * sinf(TransformRadian(_angle)), _centerCircle.y - _shortradius * cosf(TransformRadian(_angle)));
    CGPathMoveToPoint(paths, NULL, _p1.x, _p1.y);
    CGPathAddLineToPoint(paths, NULL, _p2.x, _p2.y);
    CGContextAddPath(sc, paths);
    CGContextSetStrokeColorWithColor(sc, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
    CGContextSetLineWidth(sc, 4);
    CGContextDrawPath(sc, kCGPathFillStroke);
    //CGContextRelease(sc);
    
    [self setAlpha:180.0];
}

- (void)setAlpha:(float)getlength {
    //炫酷拉伸
    if (_angle >= 0 && _angle <= getlength) {
        _tempangle = _angle + 360 - getlength;
    } else {
        _tempangle = _angle - getlength;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    //画做圆圈
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_centerCircle.x, _centerCircle.y);
    
    //CGPathAddArc(path, &transform, 0, 0, _lengthradius, 0, TransformRadian(_angle), YES);
    CGPathAddRelativeArc(path, &transform, 0, 0, _lengthradius, TransformRadian(_tempangle) -(M_PI / 2), TransformRadian(getlength));
    CGPathAddRelativeArc(path, &transform, 0, 0, _shortradius, TransformRadian(_angle) - (M_PI / 2), -TransformRadian(getlength));
    
    CGContextAddPath(gc, path);
    CGContextSetLineWidth(gc, 0.1);
    float tempalpha = _angle / 360;
    int red = (int)_angle % 254;
    CGContextSetFillColorWithColor(gc, [[UIColor colorWithRed:red green:0 blue:(254 - red) alpha:tempalpha] CGColor]);
    CGContextDrawPath(gc, kCGPathFillStroke);
}


@end















