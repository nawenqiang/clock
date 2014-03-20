//
//  AppDelegate.m
//  Clockqy
//
//  Created by peter on 14-2-26.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "AppDelegate.h"
#import "AddAlarmViewController.h"
#import "EditViewController.h"
#import "ClockSqlite.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsAnnotationKey];
//    if (localNotif) {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:Nil message:@"起床" delegate:self cancelButtonTitle:@"显示" otherButtonTitles:@"取消", nil];
//        [alter show];
//    }
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:Nil message:notification.alertBody delegate:self cancelButtonTitle:@"起床" otherButtonTitles:nil];
        [alter show];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma -mark ---- alterview
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    {
        NSDate *nowdate = [NSDate date];
        NSCalendar *currentcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned int flags = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
        NSDateComponents *comps = [currentcalendar components:flags fromDate:nowdate];
        NSInteger temptime = [comps minute];
        NSString *timestr;
        if (0 < temptime && 10 > temptime) {
            timestr = [[NSString alloc] initWithFormat:@"%ld:0%ld", [comps hour], [comps minute]];
        } else {
            timestr = [[NSString alloc] initWithFormat:@"%ld:%ld", [comps hour], [comps minute]];
        }
        
        ClockSqlite *delegateclock = [[ClockSqlite alloc]init];
        NSMutableArray *delegatearray = [[NSMutableArray alloc]init];
        delegatearray = [delegateclock SelectClock];
        
        for (int i = 0; i < [delegatearray count]; i++) {
            delegateclock = [delegatearray objectAtIndex:i];
            if ([delegateclock.clockValue isEqualToString:timestr]) {
                delegateclock.ynValue = 0;
                [delegateclock UpdateClock:delegateclock];
                break;
            }
        }
    }
}

@end
