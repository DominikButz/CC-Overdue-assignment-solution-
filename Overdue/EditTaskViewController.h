//
//  EditTaskViewController.h
//  Overdue
//
//  Created by Dominik Butz on 14.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDetailsVCViewController.h"
#import "TaskObject.h"

@interface EditTaskViewController : UIViewController

@property (strong, nonatomic) TaskObject * task;
@property (strong, nonatomic) NSIndexPath *path;
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;


@end
