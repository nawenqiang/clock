//
//  ClockViewController.h
//  Clockqy
//
//  Created by peter on 14-2-26.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *clockTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockyearLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockMLabel;

- (void) updateTime;
- (void)myweekday:(NSInteger)weekday;

@end