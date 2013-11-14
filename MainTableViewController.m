//
//  MainTableViewController.m
//  Overdue
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "MainTableViewController.h"
#import "TaskObject.h"
#import "AddTaskViewController.h"
#import "TaskDetailsVCViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

#pragma lazy instantiation 
// IMPORTANT: this getter-instantiation method must have the same name as the property!!
-(NSMutableArray *) taskArray{
    
    if (!_taskArray) {
        _taskArray = [[NSMutableArray alloc]init];
    }
    
    return _taskArray;
}

#pragma main methods

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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //see helper methods below - loads task objects into self.taskArray:
    [self loadTaskObjectsFromNSUserDefaults];
    
            
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation:

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        
        addTaskVC.delegate = self;
        
    }
    
    
    else if ([segue.destinationViewController isKindOfClass:[TaskDetailsVCViewController class]]) {
        
        TaskDetailsVCViewController *targetVC = segue.destinationViewController;
        
        //create indexpath object and set it to sender (which is the accessory button in this case:
        NSIndexPath *path = sender;
        
        //need to hand over a specific task object from the taskArray, therefore create a task object:
        TaskObject *selectedObject;
        
        // the task-objet must be the one with the sender's indexPath row:
            selectedObject  = self.taskArray[path.row];
        
        //finally, set the target VC's task property to the selected object (need to create the property in the targetVC's h-file first!):
        targetVC.task = selectedObject;
        targetVC.path = path;
        
        //set delegate to self because need to refresh table view after editing and saving! See below method: updateTask
        targetVC.delegate = self;
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return [self.taskArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
   TaskObject *task = [self.taskArray objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = task.title;
    //see helper method below: need to format NSDate object:
    NSDate *dateUnFormatted = task.date;
    NSString *formattedDate = [self dateAsString:dateUnFormatted];
    
    cell.detailTextLabel.text = formattedDate;
    
    if ( ([self isDate:[NSDate date] laterThan:task.date]) && (task.completed == NO) ) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    else if ( ([self isDate:[NSDate date] laterThan:task.date]) && (task.completed == YES) ){
        cell.backgroundColor = [UIColor greenColor];
        
    }
        
    else if ((![self isDate:[NSDate date] laterThan:task.date]) && (task.completed == NO)) {
         cell.backgroundColor = [UIColor yellowColor];
        
    }
    
    else if ((![self isDate:[NSDate date] laterThan:task.date]) && (task.completed == YES)){
        
        cell.backgroundColor = [UIColor greenColor];
    }
  
    
    return cell;
    
}


// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        // first remove the selected task object from the taskArray
        [self.taskArray removeObjectAtIndex:indexPath.row];
        
        // initialize a new Mutable array:
        NSMutableArray *tasksAsPropertyListsNew = [[NSMutableArray alloc]init];
        
        // then load each task from the taskArray into a dictionary and add the dictionaries to the new array:
        for (TaskObject *task in self.taskArray) {
            NSDictionary *dictionary = [self TaskObjectAsPropertyList:task];
            
            [tasksAsPropertyListsNew addObject:dictionary];
        }
        //load new array into NSUserDefaults and sync!
        [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyListsNew forKey:TASK_LIST];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // graphical deletion last, otherwise error!
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        
       
    }
    
    
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    
//    }
}


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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskObject *tappedTask = self.taskArray[indexPath.row];
    
    
    [self updateCompletionOfTask:tappedTask forIndexPath:indexPath];
    
    
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"toTaskDetailsVC" sender:indexPath];
    

}


- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:sender];
    
    
}


#pragma mark - helper method(s)

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

-(BOOL) isDate:(NSDate *)date1 laterThan: (NSDate*)date2{
    // timeInterval in seconds (!):
    int timeInterval1 = [date1 timeIntervalSince1970];
    int timeInterval2 = [date2 timeIntervalSince1970];
    
    if (timeInterval1 > timeInterval2) {
        return YES;
    }
    
    else return NO;
    
}

-(NSDictionary *) TaskObjectAsPropertyList: (TaskObject*)taskObject;{
    NSDictionary *dictionary = @{TASK_TITLE: taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DUEDATE: taskObject.date, TASK_COMPLETED: @(taskObject.completed)};
    
    return dictionary;
    

}


-(void) loadTaskObjectsFromNSUserDefaults {
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST];
    
    for (NSDictionary *taskAsDictionary in tasksAsPropertyLists) {
        
        TaskObject *task = [[TaskObject alloc] initWithData:taskAsDictionary];
        [self.taskArray addObject:task];
        
    }
    
}

-(void)updateCompletionOfTask:(TaskObject *)task forIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (!task.completed) {
        task.completed = YES;
    }
    
    else if (task.completed) {
        
        task.completed = NO;
    }
    
    [self.taskArray replaceObjectAtIndex:indexPath.row withObject:task];
    
    NSMutableArray *tasksAsPropertyListsUpdated = [[NSMutableArray alloc]init];
    
    for (TaskObject *taskObject in self.taskArray) {
        
        [tasksAsPropertyListsUpdated addObject:[self TaskObjectAsPropertyList:taskObject]];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyListsUpdated forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

#pragma mark - AddTaskVCDelegate methods:

-(void)didCancel{
    
    [self dismissViewControllerAnimated:YES completion:nil  ];
    
    
}


-(void)didAddTask:(TaskObject *) task {
    
     //add latest task passed in :
    [self.taskArray addObject:task];
    NSLog(@"Here is the task array: %@", self.taskArray);
    
       NSMutableArray *tasksAsPropertyLists = [  [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    
    
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc]init];
    
   
    [tasksAsPropertyLists addObject: [self TaskObjectAsPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_LIST];
    
    // saving only works with this method call (!!):
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
   
}

#pragma - TaskDetailsVCDelegate:

-(void) updateTask{
    
    [self.tableView reloadData];
}


@end
