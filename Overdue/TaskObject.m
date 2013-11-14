//
//  TaskObject.m
//  Prereq for Overdue Assignment
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "TaskObject.h"

@implementation TaskObject


-(id)init{
    
    self =  [self initWithData:nil];
    return self;
}

-(id) initWithData:(NSDictionary *)data{
    
    
   self = [super init];
    
    if (self) {
    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.date = data[TASK_DUEDATE];
    
    self.completed =[data[TASK_COMPLETED] boolValue];
        
    }
    return self;
}
    
    



@end
