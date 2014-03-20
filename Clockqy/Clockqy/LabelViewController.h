//
//  LabelViewController.h
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getLabelDelegate <NSObject>

- (void)getLabelNString:(NSString *)str;

@end

@interface LabelViewController : UITableViewController

@property (weak, nonatomic) id <getLabelDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *labelAlarm;
@property (weak, nonatomic) NSString *tempLabel;

//done return
- (IBAction)textFieldDoneEditing:(id)sender;
// background return
- (IBAction)backgroundTap:(id)sender;
- (IBAction)addLabelDone:(id)sender;

@end
