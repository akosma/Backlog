//
//  RootViewController.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright akosma software 2009. All rights reserved.
//

@class DataProvider;

@interface RootViewController : UITableViewController 
{
@private
    DataProvider *_dataProvider;
}

- (IBAction)addTask:(id)sender;
- (IBAction)shuffleTasks:(id)sender;

@end
