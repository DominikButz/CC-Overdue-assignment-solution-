//
//  TaskDetailsVCViewController.h
//  Overdue
//
//  Created by Dominik Butz on 13.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"
#import "EditTaskViewController.h"

@protocol TaskDetailsVCDelegate <NSObject>

-(void)updateTask;

@end


@interface TaskDetailsVCViewController : UIViewController <EditTaskViewControllerDelegate>

@property (weak, nonatomic) id <TaskDetailsVCDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *DescriptionLabel;

// needs to display task, therfore create property
@property (strong, nonatomic) TaskObject *task;
@property (strong, nonatomic) NSIndexPath *path;


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;



@end
