//
//  EditViewController.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockSqlite.h"

@protocol EditDataDelegate <NSObject>

- (void)getEditClockDate:(ClockSqlite *)tempClock;

@end

@interface EditViewController : UITableViewController

@property (nonatomic, strong) UILocalNotification *AlarmNotifcation;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (nonatomic, strong) NSDate *getDate;
@property (nonatomic, strong) NSString *getDateValue;
@property (nonatomic, strong) NSString *getTime;
@property (nonatomic, strong) NSString *getoldTime;
@property (nonatomic, strong) NSString *getLabel;
@property (nonatomic, strong) NSMutableString *getRepeat;
@property (nonatomic, strong) NSString *getSounds;
@property (nonatomic, strong) ClockSqlite *clockupdate;
@property int getID;
@property int compareTime;

- (IBAction)DatePicker:(UIDatePicker *)sender;
- (IBAction)editSave:(id)sender;
- (void)AddNotification;

@end
