//
//  RootViewController.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import "RootViewController.h"
#import "DataProvider.h"
#import "TaskDetailController.h"
#import "Task.h"

@implementation RootViewController

- (void)dealloc 
{
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    _dataProvider = [DataProvider sharedDataProvider];
    self.title = @"Backlog";

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)addTask:(id)sender
{
    [[DataProvider sharedDataProvider] addTask];
    [self.tableView reloadData];
}

- (IBAction)shuffleTasks:(id)sender
{
    [[DataProvider sharedDataProvider] shuffleTasks];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [_dataProvider count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Task *task = [_dataProvider taskAtIndex:indexPath.row];
    cell.textLabel.text = task.name;
    if (task.done)
    {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    else 
    {
        cell.textLabel.textColor = [UIColor redColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    Task *task = [_dataProvider taskAtIndex:indexPath.row];
    TaskDetailController *anotherViewController = [[TaskDetailController alloc] init];
    anotherViewController.task = task;
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [anotherViewController release];
}

-   (void)tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
  forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        Task *task = [_dataProvider taskAtIndex:indexPath.row];
        [[DataProvider sharedDataProvider] removeTask:task];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                         withRowAnimation:UITableViewRowAnimationFade];
    }   
}

-  (void)tableView:(UITableView *)tableView 
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
       toIndexPath:(NSIndexPath *)toIndexPath 
{
    [[DataProvider sharedDataProvider] swapTaskAtIndex:fromIndexPath.row withTaskAtIndex:toIndexPath.row];
}

@end
