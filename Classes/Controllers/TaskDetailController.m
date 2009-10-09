//
//  TaskDetailController.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "TaskDetailController.h"
#import "DataProvider.h"
#import "Task.h"

@implementation TaskDetailController

@synthesize task = _task;

#pragma mark -
#pragma mark Init and dealloc

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

#pragma mark -
#pragma mark IBAction methods

- (IBAction)changeDoneStatus:(id)sender
{
    _task.done = _taskDoneField.on;
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.title = @"Task Editor";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _taskNameField.text = _task.name;
    _taskDoneField.on = _task.done;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_taskNameField resignFirstResponder];
    _task.name = _taskNameField.text;
    _task.done = _taskDoneField.on;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_taskNameField resignFirstResponder];
    _task.name = _taskNameField.text;
    return YES;
}

@end
