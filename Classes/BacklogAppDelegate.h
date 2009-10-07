//
//  BacklogAppDelegate.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@interface BacklogAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

