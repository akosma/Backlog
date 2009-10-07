//
//  BacklogAppDelegate.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "BacklogAppDelegate.h"
#import "RootViewController.h"
#import "DataProvider.h"

@implementation BacklogAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)sendEmail:(id)sender
{
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    
    NSString *title = @"Backlog tasks";
    NSMutableString *body = [[NSMutableString alloc] init];
    [body appendString:@"<h2>Backlog tasks:</h2>"];
    [body appendString:@"<ul>"];
    
    NSArray *tasks = [[DataProvider sharedDataProvider] tasks];
    for (id task in tasks)
    {
        NSString *name = [task objectForKey:@"name"];
        BOOL done = [[task objectForKey:@"done"] boolValue];
        NSString *doneString = (done) ? @"YES" : @"NO";
        [body appendFormat:@"<li>%@; done: %@</li>", name, doneString];
    }
    [body appendString:@"</ul>"];
    
    [composer setSubject:title];
    [composer setMessageBody:body isHTML:YES];
    
    [self.navigationController presentModalViewController:composer animated:YES];    
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

@end

