//
//  BacklogAppDelegate.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface BacklogAppDelegate : NSObject <UIApplicationDelegate, 
                                          MFMailComposeViewControllerDelegate> 
{
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)sendEmail:(id)sender;

@end

