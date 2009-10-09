//
//  BacklogAppDelegate.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface BacklogAppDelegate : NSObject <UIApplicationDelegate, 
                                          MFMailComposeViewControllerDelegate,
                                          UIAccelerometerDelegate> 
{
@private
    CFTimeInterval _lastTime;
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)sendEmail:(id)sender;

@end

