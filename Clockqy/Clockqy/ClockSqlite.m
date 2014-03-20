//
//  ClockSqlite.m
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ClockSqlite.h"

@implementation ClockSqlite

- (id)init {
    _labelValue = [[NSString alloc]initWithFormat:@"闹钟"];
    _clockValue = [[NSString alloc]init];
    _soundsValue = [[NSString alloc] init];
    _dateValue = [[NSString alloc] init];
    return self;
}

- (bool)openSql {
    NSArray *temppath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [temppath objectAtIndex:0];
    NSString *path = [dir stringByAppendingString:DBFILENAME];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL dbfile = [filemanager fileExistsAtPath:path];
    
    if (dbfile) {
        if (sqlite3_open([path UTF8String], &_clockdb)) {
            sqlite3_close(self.clockdb);
            return NO;
        }
        [self CreateClock:self.clockdb];
        return YES;
    }
    if (sqlite3_open([path UTF8String], &_clockdb)) {
        [self CreateClock:self.clockdb];
        return YES;
    }
    return NO;
}

- (BOOL)CreateClock:(sqlite3 *)createclockdb {
    sqlite3_stmt *statement = NULL;
    static char *sql = "create table if not exists clockAlarm(clockID int, clockValue text, labelValue text,repeatValue  text, soundsValue text, dateValue text, ynValue bool)";
    
    if (SQLITE_OK != sqlite3_prepare_v2(_clockdb, sql , -1, &statement, NULL)) {
        return NO;
    }
    
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (SQLITE_DONE != success) {
        return NO;
    }
    return YES;
}

- (BOOL)InsertClock:(ClockSqlite *)insertclockdb {
    if ([self openSql]) {
        sqlite3_stmt *statement = NULL;
        static char *sql = "INSERT INTO clockAlarm(clockID, clockValue, labelValue, repeatValue, soundsValue, dateValue, ynValue) VALUES(?,?,?,?,?,?,?)";
        if (SQLITE_OK != sqlite3_prepare_v2(_clockdb, sql, -1, &statement, NULL)) {
            sqlite3_close(_clockdb);
            return NO;
        }
        sqlite3_bind_int(statement, 1, insertclockdb.clockid);
        sqlite3_bind_text(statement, 2, [insertclockdb.clockValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [insertclockdb.repeatValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [insertclockdb.labelValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [insertclockdb.soundsValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [insertclockdb.dateValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 7, insertclockdb.ynValue);
        
        int success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (SQLITE_ERROR == success) {
            sqlite3_close(_clockdb);
            return NO;
        }
        sqlite3_close(_clockdb);
        return YES;
    }
    return NO;
}

- (BOOL)DeleteClock:(NSMutableArray *)deletearray {
    if ([self openSql]) {
        sqlite3_stmt *statement = NULL;
        static char *sql = "DELETE FROM clockAlarm";
        if (SQLITE_OK != sqlite3_prepare_v2(_clockdb, sql, -1, &statement, NULL)) {
            sqlite3_close(_clockdb);
            return NO;
        }
        
        int success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (SQLITE_ERROR == success) {
            sqlite3_close(_clockdb);
            return NO;
        }
        
        int clockid;
        ClockSqlite *tempsqlite;
        for (clockid = 0; clockid < [deletearray count]; clockid++) {
            tempsqlite = [deletearray objectAtIndex:clockid];
            tempsqlite.clockid = clockid;
            [self InsertClock:tempsqlite];
        }
        
        sqlite3_close(_clockdb);
        return YES;
    }
    return YES;
}

- (BOOL)UpdateClock:(ClockSqlite *)updateclockdb {
    if ([self openSql]) {
        sqlite3_stmt *statement = NULL;
        static char *sql = "UPDATE clockAlarm SET labelValue = ?, clockValue = ?, repeatValue = ?, soundsValue = ?, dateValue = ?, ynValue = ? WHERE clockID = ?";
        if (SQLITE_OK != sqlite3_prepare_v2(_clockdb, sql, -1, &statement, NULL)) {
            sqlite3_close(_clockdb);
            return NO;
        }
        sqlite3_bind_text(statement, 1, [updateclockdb.labelValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [updateclockdb.clockValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [updateclockdb.repeatValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [updateclockdb.soundsValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [updateclockdb.dateValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 6, updateclockdb.ynValue);
        sqlite3_bind_int(statement, 7, updateclockdb.clockid);
        
        int success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        
        if (SQLITE_ERROR == success) {
            sqlite3_close(_clockdb);
            return NO;
        }
        sqlite3_close(_clockdb);
        return YES;
    }
    return NO;
}

- (NSMutableArray *)SelectClock {
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
    if ([self openSql]) {
        sqlite3_stmt *statement = NULL;
        static char *sql = "SELECT clockID,clockValue,labelValue,soundsValue,repeatValue,dateValue,ynValue FROM clockAlarm";
        if (SQLITE_OK != sqlite3_prepare_v2(_clockdb,sql, -1, &statement, NULL)) {
            sqlite3_close(_clockdb);
            return NO;
        } else {
            while (SQLITE_ROW == sqlite3_step(statement)) {
                ClockSqlite *clocksql = [[ClockSqlite alloc]init];
                clocksql.clockid = sqlite3_column_int(statement, 0);
                char *strText = (char*)sqlite3_column_text(statement, 1);
                clocksql.clockValue = [NSString stringWithUTF8String:strText];
                char *strTextlabel = (char*)sqlite3_column_text(statement, 2);
                clocksql.labelValue = [NSString stringWithUTF8String:strTextlabel];
                char *strTextSounds = (char*)sqlite3_column_text(statement, 3);
                clocksql.soundsValue = [NSString stringWithUTF8String:strTextSounds];
                char *strTextRepeat = (char*)sqlite3_column_text(statement, 4);
                clocksql.repeatValue = [NSMutableString stringWithUTF8String:strTextRepeat];
                char *strTextDate = (char*)sqlite3_column_text(statement, 5);
                clocksql.dateValue = [NSString stringWithUTF8String:strTextDate];
                clocksql.ynValue = sqlite3_column_int(statement, 6);
                [array addObject:clocksql];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_clockdb);
    }
    return array;
}

@end
