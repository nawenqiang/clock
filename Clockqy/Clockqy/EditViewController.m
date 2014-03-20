//
//  EditViewController.m
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "EditViewController.h"
#import "LabelViewController.h"
#import "RepeatViewController.h"
#import "SongAlarmViewController.h"


@interface EditViewController () <getLabelDelegate, getRepeatDelegate, getSoundDelegate>

@property (weak, nonatomic) id<getLabelDelegate, getRepeatDelegate, getSoundDelegate, EditDataDelegate> delegate;

@end

@implementation EditViewController

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _clockupdate = [[ClockSqlite alloc] init];
    _getSounds = [[NSString alloc] initWithFormat:@"Sounds"];
    
    NSDate *nowdate = [NSDate date];
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
    NSInteger temptime = [comps minute];
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
    // _getAddDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UpdateLabel"]) {
        LabelViewController *labelView = segue.destinationViewController;
        labelView.tempLabel= _getLabel;
    }
    
    if ([segue.identifier isEqualToString:@"UpdateRepeat"]) {
        RepeatViewController *repeatView = segue.destinationViewController;
        repeatView.tempRepeat = _getRepeat;
    }
    
    if ([segue.identifier isEqualToString:@"UpdateSounds"]) {
        ;
    }
    
    if ([segue.identifier isEqualToString:@"UpdateLabel"] || [segue.identifier isEqualToString:@"UpdateRepeat"] || [segue.identifier isEqualToString:@"UpdateSounds"]) {
        
        EditViewController *editAlarmViewController = segue.destinationViewController;
        editAlarmViewController.delegate = self;
        self.hidesBottomBarWhenPushed = YES;
    }
    
}

- (IBAction)DatePicker:(UIDatePicker *)sender {
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [currentcalendar setTimeZone:[NSTimeZone defaultTimeZone]];
    comps = [currentcalendar components:flags fromDate:sender.date];
    NSInteger temptime = [comps minute];
    //获取控件时间
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
    //_getDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
    _getDate = [currentcalendar dateFromComponents:comps];
    _getDateValue = [[NSString alloc] initWithFormat:@"%@", _getDate];
    
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    _compareTime = (int)(tempyear * 60 + tempminute);
}

- (IBAction)editSave:(id)sender {
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [currentcalendar setTimeZone:[NSTimeZone defaultTimeZone]];
    comps = [currentcalendar components:flags fromDate:_DatePicker.date];
    NSInteger temptime = [comps minute];
    //获取控件时间
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
    //_getDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
    _getDate = [currentcalendar dateFromComponents:comps];
    _getDateValue = [[NSString alloc] initWithFormat:@"%@", _getDate];
    
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    _compareTime = (int)(tempyear * 60 + tempminute);
    
    
    //sqlite
    _clockupdate.clockValue = _getTime;
    _clockupdate.labelValue = _getLabel;
    _clockupdate.repeatValue = _getRepeat;
    _clockupdate.soundsValue = _getSounds;
    _clockupdate.dateValue = _getDateValue;
    
    NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
    for (int i=0; i<[myArray count]; i++) {
        UILocalNotification    *myUILocalNotification=[myArray objectAtIndex:i];
        NSLog(@"%d", [[[myUILocalNotification userInfo] objectForKey:@"key1"] intValue]);
        NSString *str = [[NSString alloc] init];
        str = [NSString stringWithFormat:@"%@",_getoldTime];
        if ([[[myUILocalNotification userInfo] objectForKey:str] intValue] == 1) {
            [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
        }
    }
    //调用设置闹钟
    [self AddNotification];
    
    [self.delegate getEditClockDate:_clockupdate];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)AddNotification {
    _AlarmNotifcation = [[UILocalNotification alloc] init];
    _AlarmNotifcation.fireDate = _getDate;
    _AlarmNotifcation.timeZone = [NSTimeZone defaultTimeZone];
    _AlarmNotifcation.alertBody = _getTime;
    _AlarmNotifcation.soundName = @"qy.caf";
    
    NSDate *nowdate = [NSDate date];
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
    
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    int temp = (int)(tempyear * 60 + tempminute);

    if (temp <= _compareTime) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",1], [NSString stringWithFormat:@"%@",_getTime], nil];
        [_AlarmNotifcation setUserInfo:dict];
        
        [[UIApplication sharedApplication]scheduleLocalNotification:_AlarmNotifcation];
        _clockupdate.ynValue = 1;
    } else {
        _clockupdate.ynValue = 0;
    }
}

#pragma -mark ---- delegate get info
- (void) getLabelNString:(NSString *)str {
    _getLabel = str;
}

- (void) getRepeatNSString:(NSMutableArray *)marray {
    for (NSString *strarray in marray) {
        [_getRepeat appendString:strarray];
    }
}

- (void) getSoundNSString:(NSString *)str {
    _getSounds = str;
}

@end
