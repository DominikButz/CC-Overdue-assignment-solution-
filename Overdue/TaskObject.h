//
//  TaskObject.h
//  Prereq for Overdue Assignment
//
//  Created by Dominik Butz on 10.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completed;


-(id) initWithData:(NSDictionary *)data;




@end
