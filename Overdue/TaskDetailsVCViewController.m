//
//  TaskDetailsVCViewController.m
//  Overdue
//
//  Created by Dominik Butz on 13.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "TaskDetailsVCViewController.h"
#import "EditTaskViewController.h"

@interface TaskDetailsVCViewController ()

@end

@implementation TaskDetailsVCViewController

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
    
    self.TitleLabel.text = self.task.title;
    
    self.DescriptionLabel.text = self.task.description;
    
    self.DateLabel.text = [self dateAsString:self.task.date];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toEditTaskVC" sender:sender];
}

#pragma  mark - navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
        
        EditTaskViewController *editVC = segue.destinationViewController;
        
        // hand over the task object to the editVC:
        editVC.task = self.task;
        
        //that's not enough, also need to hand over the indexPath we got from the MainTableVC:
        
        editVC.path = self.path;
        
        
        
        
    }
}


#pragma mark - helper method(s):


-(NSString*) dateAsString: (NSDate *)date{
    
    //initialize the date-formatter-object first
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //then set the date format of the date-formatter-object:
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    //then call the method stringFromDate on the dateFormatter, passing in the unformatted date and save the formatted date as string:
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    
    //return formattedDate:
    return formattedDate;
    
}
@end
