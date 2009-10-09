//
//  TaskDetailController.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TaskDetailController.h"
#import "DataProvider.h"

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
    [_task setObject:[NSNumber numberWithBool:_taskDoneField.on] forKey:@"done"];
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
    _taskNameField.text = [_task objectForKey:@"name"];
    _taskDoneField.on = [[_task objectForKey:@"done"] boolValue];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_taskNameField resignFirstResponder];
    [_task setObject:_taskNameField.text forKey:@"name"];
    [_task setObject:[NSNumber numberWithBool:_taskDoneField.on] forKey:@"done"];
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
    [_task setObject:_taskNameField.text forKey:@"name"];
    return YES;
}

@end
