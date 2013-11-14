//
//  AddTaskViewController.m
//  Overdue
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.addTaskDescriptionField.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskCancelButtonPressed:(UIBarButtonItem *)sender {
    
    [self.delegate didCancel];
    
}

- (IBAction)addTaskSaveButtonPressed:(UIBarButtonItem *)sender {
    
    //check if title field is empty (we are allowing the description to be empty):
    if ([self.addTaskTitleField.text isEqualToString:@""]) {
        
        UIAlertView *titleNotFilled = [[UIAlertView alloc]initWithTitle:@"No title" message:@"Please enter a task title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [titleNotFilled show];
    }
    
    else {
        // pass task as NSDictionary into the helper method as paramater and call helper method on self.delegate:
       
        [self.delegate didAddTask: [self returnTaskObject]];
        
    }
    
}

#pragma  mark - helper method(s)

-(TaskObject *) returnTaskObject {
    //alternative: 
//    NSDictionary *taskAsDictionary = @{TASK_TITLE: self.addTaskTitleField.text, TASK_DESCRIPTION: self.addTastDescriptionField.text, TASK_DUEDATE: self.addTaskDatePicker.date, TASK_COMPLETED: @NO};
//    
//    TaskObject *task = [[TaskObject alloc]initWithData:taskAsDictionary];
    
    TaskObject *task = [[TaskObject alloc] init];
    
    task.title =self.addTaskTitleField.text;
    task.description = self.addTaskDescriptionField.text;
    task.date = self.addTaskDatePicker.date;
    task.completed = NO;
    
    
    NSLog(@"Task object in returnTaskObject: %@", task);

    return task;
    
}

#pragma mark - textviewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if ([text isEqualToString:@"\n"]) {
        //method resignFirstResponder makes keyboard disappear - will only disappear after user taps return
        [self.addTaskDescriptionField resignFirstResponder];
        
        return NO;
    }
    
    else return YES;
}


@end
