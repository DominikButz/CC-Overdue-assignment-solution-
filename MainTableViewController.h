//
//  MainTableViewController.h
//  Overdue
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"

@interface MainTableViewController : UITableViewController <AddTaskViewControllerDelegate>



@property (strong, nonatomic) NSMutableArray *taskArray;

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;



@end
