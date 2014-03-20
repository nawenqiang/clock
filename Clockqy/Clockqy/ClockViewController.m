//
//  ClockViewController.m
//  Clockqy
//
//  Created by peter on 14-2-26.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ClockViewController.h"
#import "DDClockView.h"
#import "DDNeedleView.h"

@interface ClockViewController ()

@end

@implementation ClockViewController {
    BOOL secondinfo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    secondinfo = YES;
    
    SEL selupdate = @selector(updateTime);
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:selupdate userInfo:nil repeats:YES];
    
    DDClockView *clockView =[[DDClockView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    clockView.center =self.view.center;
    [self.view addSubview:clockView];
//
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myweekday:(NSInteger)weekday {
    NSString *strweekday;
    switch (weekday) {
        case 2:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Mon"];
            break;
        }
        case 3:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Tue"];
            break;
        }
        case 4:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Wen"];
            break;
        }
        case 5:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Thr"];
            break;
        }
        case 6:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Fri"];
            break;
        }
        case 7:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Sat"];
            break;
        }
        case 1:
        {
            strweekday = [[NSString alloc] initWithFormat:@"Sun"];
            break;
        }
        default:
            break;
    }
    _clockMLabel.text = strweekday;
}

- (void)updateTime {
    
    NSDate *nowdate = [NSDate date];
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
    
    NSInteger years = [comps year];
    NSInteger months = [comps month];
    NSInteger days = [comps day];
    NSString *stryear = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", years, months, days];
    _clockyearLabel.text = stryear;
    
    NSInteger hours = [comps hour];
    NSInteger minutes = [comps minute];
    NSInteger seconds = [comps second];
    //调整显示时间
    if (0 == seconds % 2) {
        secondinfo = YES;
    } else {
        secondinfo = NO;
    }
    NSString *strtime;
    if (10 > minutes) {
        if (YES == secondinfo) {
            strtime = [[NSString alloc]initWithFormat:@"%ld:0%ld", hours, minutes];
        } else {
            strtime = [[NSString alloc]initWithFormat:@"%ld 0%ld", hours, minutes];
        }
        
    } else {
        if (YES == secondinfo) {
            strtime = [[NSString alloc]initWithFormat:@"%ld:%ld", hours, minutes];
        } else {
            strtime = [[NSString alloc]initWithFormat:@"%ld %ld", hours, minutes];
        }
        
    }
    _clockTimeLabel.text = strtime;
    
    NSInteger weekdays = [comps weekday];
    [self myweekday:weekdays];
    
    
    
}

@end
