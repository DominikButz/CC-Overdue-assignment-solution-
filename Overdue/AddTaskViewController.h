//
//  AddTaskViewController.h
//  Overdue
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"


@protocol AddTaskViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)didAddTask: (TaskObject *) task;

@end

@interface AddTaskViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *addTaskTitleField;
@property (strong, nonatomic) IBOutlet UITextView *addTaskDescriptionField;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDatePicker;

- (IBAction)addTaskCancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskSaveButtonPressed:(UIBarButtonItem *)sender;




@end
