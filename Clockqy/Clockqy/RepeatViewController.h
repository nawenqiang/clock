//
//  RepeatViewController.h
//  Clockqy
//
//  Created by peter on 14-3-2.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getRepeatDelegate <NSObject>

- (void)getRepeatNSString:(NSMutableArray *) marray;

@end

@interface RepeatViewController : UITableViewController

@property (weak, nonatomic) id<getRepeatDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *RepeatDays;
@property (nonatomic, strong) NSMutableArray *getRepeatDays;
@property (nonatomic, strong) NSString *tempRepeat;
@property int RepeatCount;

- (IBAction)doneWeeks:(id)sender;

@end
