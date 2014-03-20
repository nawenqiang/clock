//
//  RepeatViewController.m
//  Clockqy
//
//  Created by peter on 14-3-2.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "RepeatViewController.h"

@interface RepeatViewController ()

@end

@implementation RepeatViewController

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
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    NSLog(@"%@", _tempRepeat);
    
    if (_tempRepeat) {
        ;
    }
    
    _RepeatCount = 0;
    _RepeatDays = [[NSMutableArray alloc]initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    _getRepeatDays = [[NSMutableArray alloc] initWithCapacity:7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_RepeatDays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RepeatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    NSString *strtemp = [[NSString alloc] initWithFormat:@"星期%@", [_RepeatDays objectAtIndex:row]];
    
    cell.textLabel.text = strtemp;
    
    NSString *tempstr = [[NSString alloc] initWithFormat:@"%ld", row];
    NSRange temprange = [_tempRepeat rangeOfString:tempstr];
    
    if (temprange.length > 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO]; //选一下
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];  //获取点击项
    NSString *tempstr = [[NSString alloc] initWithFormat:@"%ld ", (indexPath.row + 1)];
    if (UITableViewCellAccessoryNone == cell.accessoryType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;  //设置选中
        [_getRepeatDays addObject:tempstr];
        _RepeatCount++;
        NSLog(@"%d ", _RepeatCount);
    } else if (UITableViewCellAccessoryCheckmark == cell.accessoryType) {
        cell.accessoryType = UITableViewCellSeparatorStyleNone;
        [_getRepeatDays removeObject:tempstr];
        _RepeatCount--;
        NSLog(@"%d ", _RepeatCount);
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
#pragma -mark ---- getweeks
- (IBAction)doneWeeks:(id)sender {
    
    [self.delegate getRepeatNSString:_getRepeatDays];
    //[self.delegate getRepeatNSString:<#(NSString *)#>];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
