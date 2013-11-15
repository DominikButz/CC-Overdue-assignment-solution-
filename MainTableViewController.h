//
//  MainTableViewController.h
//  Overdue
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "TaskDetailsVCViewController.h"

// for reloading data (after editing), need to conform to TaskDetailsVCDelegate, too:
@interface MainTableViewController : UITableViewController <AddTaskViewControllerDelegate, TaskDetailsVCDelegate>



@property (strong, nonatomic) NSMutableArray *taskArray;

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;



@end
