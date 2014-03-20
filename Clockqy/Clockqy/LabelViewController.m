//
//  LabelViewController.m
//  Clockqy
//
//  Created by peter on 14-3-3.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "LabelViewController.h"
#import "AddAlarmViewController.h"

@interface LabelViewController ()

@end

@implementation LabelViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    _labelAlarm.text = _tempLabel;
    NSLog(@"%@", _labelAlarm.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)backgroundTap:(id)sender {
    [_labelAlarm resignFirstResponder];
}

- (IBAction)addLabelDone:(id)sender {
    [self.delegate getLabelNString:_labelAlarm.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
