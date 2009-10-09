//
//  TaskDetailController.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TaskDetailController : UIViewController <UITextFieldDelegate>
{
@private
    NSMutableDictionary *_task;
    
    IBOutlet UITextField *_taskNameField;
    IBOutlet UISwitch *_taskDoneField;
}

@property (nonatomic, retain) NSMutableDictionary *task;

- (IBAction)changeDoneStatus:(id)sender;

@end
