//
//  AlarmViewController.m
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "AlarmViewController.h"
#import "ClockSqlite.h"
#import "EditViewController.h"
#import "AddAlarmViewController.h"

@interface AlarmViewController () <AddDataDelegate, EditDataDelegate>

@property (weak, nonatomic) id<AddDataDelegate, EditDataDelegate> delegate;

@end

@implementation AlarmViewController

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

    ClockSqlite *alarmsql = [[ClockSqlite alloc] init];
    _numAlarm = [[NSMutableArray alloc] init];
    _numAlarm = [alarmsql SelectClock];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)viewWillAppear:(BOOL)animated {
    ClockSqlite *alarmwillappear = [[ClockSqlite alloc] init];
    _numAlarm = [alarmwillappear SelectClock];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAlarm:(id)sender {
    //[self.navigationController pushViewController:addAlarm animated:YES];
}

#pragma -mark  --- switch selector      switchaction
-(void)switchAction:(id)sender  {
    
    UISwitch *switchview = (UISwitch*)sender;
    NSLog(@"%ld", switchview.tag);
    BOOL isSwitch = [switchview isOn];
    ClockSqlite *switchsqlite = [[ClockSqlite alloc]init];
    switchsqlite = [_numAlarm objectAtIndex:switchview.tag];
    
    if (!isSwitch) {
        int j = 0;
        for (int i = 0; i < switchview.tag; i++) {
            ClockSqlite *tempswitch = [[ClockSqlite alloc]init];
            tempswitch = [_numAlarm objectAtIndex:i];
            if (tempswitch.ynValue == 0) {
                j++;
            }
        }
        //关闭
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        UILocalNotification *myUILocalNotification=[myArray objectAtIndex:switchview.tag - j];
        NSLog(@"%d", [[[myUILocalNotification userInfo] objectForKey:@"key1"] intValue]);
        [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
        switchsqlite.ynValue = 0;
    } else {
        //打开
        //日期转换
        NSDate *tempdate = [[NSDate alloc]init];
        NSDateFormatter *tempformatter = [[NSDateFormatter alloc]init];
        [tempformatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [tempformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [tempformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
        NSString *strdate = [[NSString alloc]init];
        strdate = [switchsqlite.dateValue substringWithRange:NSMakeRange(0, 19)];
        tempdate = [tempformatter dateFromString:strdate];
        
        _AlarmNotifcation = [[UILocalNotification alloc] init];
        _AlarmNotifcation.fireDate = tempdate;
        _AlarmNotifcation.timeZone = [NSTimeZone defaultTimeZone];
        _AlarmNotifcation.alertBody = switchsqlite.clockValue;
        _AlarmNotifcation.soundName = @"qy.caf";
        
        NSDate *nowdate = [NSDate date];
        NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
        NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
        NSDateComponents *comparecomps = [currentcalendar components:flags fromDate:tempdate];
        int tempyear = (int)[comps year];
        int tempminute = (int)[comps minute];
        //当前时间
        int temp = (int)(tempyear * 60 + tempminute);
        //获取时间
        int compareTime = (int)((int)[comparecomps year] * 60 + (int)[comparecomps minute]);
        
        if (temp >= compareTime) {
            NSTimeInterval secondsPerDay2 = 24 * 60 * 60;
            NSDate *tomorrow2 = [tempdate dateByAddingTimeInterval:secondsPerDay2];
            _AlarmNotifcation.fireDate = tomorrow2;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",1], [NSString stringWithFormat:@"%@",switchsqlite.clockValue], nil];
        [_AlarmNotifcation setUserInfo:dict];
        
        [[UIApplication sharedApplication]scheduleLocalNotification:_AlarmNotifcation];
        switchsqlite.ynValue = 1;
    }
    switchsqlite.clockid = switchview.tag;
    [switchsqlite UpdateClock:switchsqlite];
}

#pragma -mark ---- table view cell
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editTableidentifier"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        _tempid = (int)indexPath.row;

        AlarmViewController *alarmViewController = segue.destinationViewController;
        alarmViewController.delegate = self;
        
        EditViewController *editView = [[EditViewController alloc]init];
        editView = segue.destinationViewController;
        editView.getID = _tempid;
        ClockSqlite *clockupdate = [[ClockSqlite alloc] init];
        clockupdate = [_numAlarm objectAtIndex:indexPath.row];
        editView.getoldTime = clockupdate.clockValue;
        editView.getLabel = clockupdate.labelValue;
        editView.getRepeat = clockupdate.repeatValue;
        editView.getSounds = clockupdate.soundsValue;
        
    } else if ([segue.identifier isEqualToString:@"addTableidentifier"]) {
        _tempid = (int)[_numAlarm count];
        AlarmViewController *alarmViewController = segue.destinationViewController;
        alarmViewController.delegate = self;
        
        AddAlarmViewController *addAlarm = [[AddAlarmViewController alloc] init];
        addAlarm = segue.destinationViewController;
        addAlarm.addID = _tempid;
        
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_numAlarm count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlarmClock";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ClockSqlite *alarmcell = [[ClockSqlite alloc] init];
    alarmcell = [_numAlarm objectAtIndex:indexPath.row];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@     %@", alarmcell.clockValue, alarmcell.labelValue];
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.tag = indexPath.row;
    
    //设置定时
    NSDate *tempdate = [[NSDate alloc]init];
    NSDateFormatter *tempformatter = [[NSDateFormatter alloc]init];
    [tempformatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [tempformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [tempformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *strdate = [[NSString alloc]init];
    strdate = [alarmcell.dateValue substringWithRange:NSMakeRange(0, 19)];
    tempdate = [tempformatter dateFromString:strdate];
    
    _AlarmNotifcation = [[UILocalNotification alloc] init];
    _AlarmNotifcation.fireDate = tempdate;
    _AlarmNotifcation.timeZone = [NSTimeZone defaultTimeZone];
    _AlarmNotifcation.alertBody = alarmcell.clockValue;
    _AlarmNotifcation.soundName = @"qy.caf";
    
    NSDate *nowdate = [NSDate date];
    NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
    NSDateComponents *comparecomps = [currentcalendar components:flags fromDate:tempdate];
    int tempyear = (int)[comps year];
    int tempminute = (int)[comps minute];
    int temp = (int)(tempyear * 60 + tempminute);
    int compareTime = (int)((int)[comparecomps year] * 60 + (int)[comparecomps minute]);
    
    if (alarmcell.ynValue == 1) {
        [switchview setOn:YES];
        if (temp >= compareTime) {
            NSTimeInterval secondsPerDay = 24 * 60 * 60;
            NSDate *tomorrow = [tempdate dateByAddingTimeInterval:secondsPerDay];
            _AlarmNotifcation.fireDate = tomorrow;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",1], [NSString stringWithFormat:@"%@",alarmcell.clockValue], nil];
        [_AlarmNotifcation setUserInfo:dict];
        
        [[UIApplication sharedApplication]scheduleLocalNotification:_AlarmNotifcation];
        [switchview setOn:YES];
    } else {
        [switchview setOn:NO];
        
    }
    [switchview addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = switchview;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        ClockSqlite *clockupdate = [[ClockSqlite alloc] init];
        clockupdate = [_numAlarm objectAtIndex:indexPath.row];
        [_numAlarm removeObjectAtIndex:indexPath.row];
        
        //NSLog(@"%d", indexPath.row);
        
        
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (int i=0; i<[myArray count]; i++) {
            UILocalNotification    *myUILocalNotification=[myArray objectAtIndex:i];
            NSLog(@"%d", [[[myUILocalNotification userInfo] objectForKey:@"key1"] intValue]);
            NSString *str = [[NSString alloc] init];
            str = [NSString stringWithFormat:@"%@",clockupdate.clockValue];
            if ([[[myUILocalNotification userInfo] objectForKey:str] intValue] == 1) {
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
            }
        }
        
        [tableView reloadData];
        [clockupdate DeleteClock:_numAlarm];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma -mark  --- delegate   add and edit  
- (void)getAddClockData:(ClockSqlite *)tempClock {
    tempClock.clockid = _tempid;
    [tempClock InsertClock:tempClock];
}

- (void)getEditClockDate:(ClockSqlite *)tempClock {
    tempClock.clockid = _tempid;
    int count = 0;
    ClockSqlite *tempsqlite = [_numAlarm objectAtIndex:_tempid];
    if ([tempClock.labelValue isEqualToString:@"闹钟"]) {
        count++;
        tempClock.labelValue = tempsqlite.labelValue;
    }
    if ([tempClock.repeatValue isEqualToString:@""]) {
        count++;
        tempClock.repeatValue = tempsqlite.repeatValue;
    }
    if ([tempClock.clockValue isEqualToString:@""]) {
        count++;
        tempClock.clockValue = tempsqlite.clockValue;
    }
    if ([tempClock.soundsValue isEqualToString:@"Sounds"]) {
        count++;
        tempClock.soundsValue = tempsqlite.soundsValue;
    }
    if (4 != count) {
        [tempClock UpdateClock:tempClock];
    }
}

@end
