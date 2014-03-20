//
//  WatchViewController.m
//  Clockqy
//
//  Created by peter on 14-2-27.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "WatchViewController.h"

@interface WatchViewController ()

@end

@implementation WatchViewController
{
    int time_lap;
    int time;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    checked = YES;
    checklap = NO;
    time = 0;
    time_lap = 0;
    laparray = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startstop:(id)sender {
    NSString *title = (!checked) ? (@"Start") : (@"Stop");
    NSString *laptilte = (!checked) ? (@"Reset") : (@"Lap");
    [_startstopLabel setTitle:title forState:UIControlStateNormal];
    [_lapresetLabel setTitle:laptilte forState:UIControlStateNormal];
    
    SEL updateselector = @selector(updateTimer);
    
    if (checked) {  //start
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:updateselector userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    } else {  //stop
        [_timer invalidate];
    }
    
    
    checked = !checked;
}

- (IBAction)lapreset:(id)sender {
    if (checked) { //reset
        [_totalTimerLabel setText:@"00:00.00"];
        [_lapTimerLabel setText:@"00:00.00"];
        [_lapresetLabel setTitle:@"Lap" forState:UIControlStateNormal];
        
        time = 0;
        time_lap = 0;
        //delete array
        [laparray removeAllObjects];
        //reload data
        [_tableView reloadData];
    } else {  //lap
        checklap = YES;
        time_lap = 0;
    }
}

- (void)updateTimer {
    time++;
    time_lap++;
    
    if (360000 == time_lap || 360000 == time) {
        time = 0;
        time_lap = 0;
    }
    
    [self setTimerLabel:_totalTimerLabel :time];
    [self setTimerLabel:_lapTimerLabel :time_lap];
}

- (void)setTimerLabel:(UILabel *)templabel :(NSInteger)tempdate {
    NSInteger min;
    NSInteger second;
    NSInteger MS;
    NSInteger MMS;
    
    NSString *tempstr;
    
    min = (tempdate / (100 * 60)) % 60;   //0-60
    second = (tempdate / 100) % 60;    //0-60
    MS = (tempdate / 10) % 10;   //0--10
    MMS = tempdate % 10;
    
    if (10 > second) {
        if (10 > min) {
            tempstr = [[NSString alloc] initWithFormat:@"0%ld:0%ld.%ld%ld", min, second, MS, MMS];
            templabel.text = tempstr;
        } else {
            tempstr = [[NSString alloc] initWithFormat:@"%ld:0%ld.%ld%ld", min, second, MS, MMS];
            templabel.text = tempstr;
        } // min else
    } else {
        if (10 > min) {
            tempstr = [[NSString alloc] initWithFormat:@"0%ld:%ld.%ld%ld", min, second, MS, MMS];
            templabel.text = tempstr;
        } else {
            tempstr = [[NSString alloc] initWithFormat:@"%ld:%ld.%ld%ld", min, second, MS, MMS];
            templabel.text = tempstr;
        }  //min else
    }  //second else
    
    if (checklap) {
        checklap = !checklap;
        [laparray insertObject:tempstr atIndex:0];
        [_tableView reloadData];
    }
}

#pragma -mark --- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return laparray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    //set cell text
    NSInteger row = indexPath.row;
    NSString *text = [NSString stringWithFormat:@"Lap:%ld  %@", laparray.count - row, [laparray objectAtIndex:row]];
    cell.textLabel.text = text;
    return cell;
}

@end
