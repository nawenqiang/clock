//
//  AddAlarmViewController.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockSqlite.h"

@protocol AddDataDelegate <NSObject>

- (void) getAddClockData:(ClockSqlite *)tempClock;

@end

@interface AddAlarmViewController : UITableViewController

@property (nonatomic, strong) UILocalNotification *AlarmNotifcation;
@property (nonatomic, strong) NSString *addLabel;
@property (nonatomic, strong) NSMutableString  *addRepeat;
@property (nonatomic, strong) NSString *addSounds;
@property (weak, nonatomic) IBOutlet UIDatePicker *addDatePicker;
@property (nonatomic, strong) NSString *getAddTime;
@property (nonatomic, strong) NSDate *getAddDate;
@property (nonatomic, strong) NSString *getAddDateValue;
@property (nonatomic, strong) ClockSqlite *clockinsert;
@property int addID;
@property int compareTime;

- (IBAction)addActionAlarm:(UIDatePicker*)sender;
- (IBAction)addAlarm:(id)sender;
- (void)AddNotification;

@end
