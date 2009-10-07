//
//  TaskDetailController.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TaskDetailController : UIViewController 
{
@private
    NSMutableDictionary *_task;
    
    IBOutlet UITextField *_taskNameField;
    IBOutlet UISwitch *_taskDoneField;
}

@property (nonatomic, retain) NSMutableDictionary *task;

@end
