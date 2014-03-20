//
//  WatchViewController.h
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    Boolean checked;
    Boolean checklap;
    NSMutableArray *laparray;
}

@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *lapTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startstopLabel;
@property (weak, nonatomic) IBOutlet UIButton *lapresetLabel;


- (IBAction)startstop:(id)sender;
- (IBAction)lapreset:(id)sender;
- (void)updateTimer;
- (void)setTimerLabel:(UILabel*)templabel :(NSInteger)tempdate;

@end
