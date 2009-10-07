//
//  TaskDetailController.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TaskDetailController.h"

@implementation TaskDetailController

@synthesize task = _task;

- (id)init
{
    if (self = [super initWithNibName:@"TaskDetailController" bundle:nil]) 
    {
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.title = @"Task Editor";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _taskNameField.text = [_task objectForKey:@"name"];
    _taskDoneField.on = [[_task objectForKey:@"done"] boolValue];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

@end
