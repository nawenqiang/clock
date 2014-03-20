//
//  AlarmViewController.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UITableViewController

@property int tempid;
@property (nonatomic, strong) NSMutableArray *numAlarm;
@property (nonatomic, strong) UILocalNotification *AlarmNotifcation;

- (IBAction)addAlarm:(id)sender;

@end
