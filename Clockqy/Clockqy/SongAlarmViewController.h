//
//  SongAlarmViewController.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getSoundDelegate <NSObject>

- (void) getSoundNSString:(NSString *)str;

@end

@interface SongAlarmViewController : UITableViewController

@property (weak, nonatomic) id<getSoundDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *Sounds;

- (IBAction)soundsDone:(id)sender;

@end
