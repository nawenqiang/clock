//
//  AddAlarmViewController.m
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "LabelViewController.h"
#import "RepeatViewController.h"
#import "SongAlarmViewController.h"


@interface AddAlarmViewController () <getLabelDelegate, getRepeatDelegate, getSoundDelegate>

@property (strong, nonatomic) id<getLabelDelegate, getRepeatDelegate, getSoundDelegate, AddDataDelegate> delegate;

@end

@implementation AddAlarmViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    _clockinsert = [[ClockSqlite alloc] init];
    _addLabel = [[NSString alloc] initWithFormat:@"闹钟"];
    _addRepeat = [[NSMutableString alloc] initWithFormat:@""];
    _addSounds = [[NSString alloc] initWithFormat:@"Sounds"];
    
    NSDate *nowdate = [NSDate date];
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
    NSInteger temptime = [comps minute];
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
    // _getAddDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", _addLabel);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddLabel"] || [segue.identifier isEqualToString:@"AddRepeat"] || [segue.identifier isEqualToString:@"AddSounds"]) {
        AddAlarmViewController *addAlarmViewController = segue.destinationViewController;
        addAlarmViewController.delegate = self;
        self.hidesBottomBarWhenPushed = YES;
    }
    
}

- (IBAction)addActionAlarm:(UIDatePicker *)sender {
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [currentcalendar setTimeZone:[NSTimeZone defaultTimeZone]];
    comps = [currentcalendar components:flags fromDate:sender.date];
    NSInteger temptime = [comps minute];
    //获取控件时间
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
   // _getAddDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
    
    _getAddDate = [currentcalendar dateFromComponents:comps];
    _getAddDateValue = [[NSString alloc] initWithFormat:@"%@", _getAddDate];
    
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    _compareTime = (int)(tempyear * 60 + tempminute);
}

- (IBAction)addAlarm:(id)sender {
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [currentcalendar setTimeZone:[NSTimeZone defaultTimeZone]];
    comps = [currentcalendar components:flags fromDate:_addDatePicker.date];
    NSInteger temptime = [comps minute];
    //获取控件时间
    NSLog(@"%ld-%ld-%ld-%ld-%ld", [comps year], [comps month], [comps day], [comps hour], [comps minute]);
    // _getAddDate = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", [comps year], [comps month], [comps day]];
    if (0 < temptime && 10 > temptime) {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
    } else {
        _getAddTime = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
    }
    
    _getAddDate = [currentcalendar dateFromComponents:comps];
    _getAddDateValue = [[NSString alloc] initWithFormat:@"%@", _getAddDate];
    
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    _compareTime = (int)(tempyear * 60 + tempminute);
    
    
    _clockinsert.clockValue = _getAddTime;
    _clockinsert.labelValue = _addLabel;
    _clockinsert.repeatValue = _addRepeat;
    _clockinsert.soundsValue = _addSounds;
    _clockinsert.dateValue = _getAddDateValue;
    
    //调用设置闹钟
    [self AddNotification];
    
    [self.delegate getAddClockData:_clockinsert];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)AddNotification {
    _AlarmNotifcation = [[UILocalNotification alloc] init];
    _AlarmNotifcation.fireDate = _getAddDate;
    _AlarmNotifcation.timeZone = [NSTimeZone defaultTimeZone];
    _AlarmNotifcation.alertBody = _getAddTime;
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
                              [NSString stringWithFormat:@"%d",1], [NSString stringWithFormat:@"%@",_getAddTime], nil];
        [_AlarmNotifcation setUserInfo:dict];
        
        [[UIApplication sharedApplication]scheduleLocalNotification:_AlarmNotifcation];
        _clockinsert.ynValue = 1;
    } else {
        _clockinsert.ynValue = 0;
    }
}

#pragma -mark  ---- delegate  get info
- (void)getLabelNString:(NSString *)str {
    self.addLabel = str;
}

- (void)getRepeatNSString:(NSMutableArray *)marray {
    //self.addRepeat = str;
    for (NSString *strarray in marray) {
        [_addRepeat appendString:strarray];
    }
    NSLog(@"%@", _addRepeat);
}

- (void)getSoundNSString:(NSString *)str {
    self.addSounds = str;
}
@end
