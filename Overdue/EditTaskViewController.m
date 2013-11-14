//
//  EditTaskViewController.m
//  Overdue
//
//  Created by Dominik Butz on 14.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()


@end

@implementation EditTaskViewController

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
    
    self.taskTitleTextField.text = self.task.title;
    self.taskDescriptionTextField.text = self.task.description;
    self.datePicker.date = self.task.date;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
   
    // update task-properties with user input:
    self.task.title = self.taskTitleTextField.text;
    self.task.description = self.taskDescriptionTextField.text;
    self.task.date =self.datePicker.date;
    
    [self.delegate didUpdateTask:self.task];
       
  
}

@end
