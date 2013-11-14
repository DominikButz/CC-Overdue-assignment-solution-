//
//  EditTaskViewController.h
//  Overdue
//
//  Created by Dominik Butz on 14.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required
-(void) didUpdateTask:(TaskObject *) task;

@end


@interface EditTaskViewController : UIViewController

@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

//need these two properties because need to take over objects from TaskDetailsVC:
@property (strong, nonatomic) TaskObject * task;
@property (strong, nonatomic) NSIndexPath *path;

@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;


@end

