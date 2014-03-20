//
//  ClockSqlite.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define DBFILENAME @"PeterClock.db"

@interface ClockSqlite : NSObject

@property (nonatomic) sqlite3 *clockdb;
@property (nonatomic) int clockid;
@property (nonatomic, strong) NSString *clockValue;
@property (nonatomic, strong) NSMutableString *repeatValue;
@property (nonatomic, strong) NSString *labelValue;
@property (nonatomic, strong) NSString *soundsValue;
@property (nonatomic, strong) NSString *dateValue;
@property int ynValue;

- (bool)openSql;
- (BOOL)CreateClock:(sqlite3 *)createclockdb;
- (BOOL)InsertClock:(ClockSqlite *)insertclockdb;
- (BOOL)DeleteClock:(NSMutableArray *)deletearray;
- (BOOL)UpdateClock:(ClockSqlite *)updateclockdb;
- (NSMutableArray *)SelectClock;

@end
