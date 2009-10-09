//
//  BacklogAppDelegate.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import "BacklogAppDelegate.h"
#import "RootViewController.h"
#import "DataProvider.h"
#import "Task.h"

#define kAccelerometerFrequency            25   //Hz
#define kFilteringFactor                    0.1
#define kMinEraseInterval                   0.5
#define kEraseAccelerationThreshold         2.0


@implementation BacklogAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];

    [window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application 
{
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
    
    NSArray *tasks = [DataProvider sharedDataProvider].tasks;
    if ([tasks count] > 0)
    {
        for (Task *task in tasks)
        {
            NSString *doneString = (task.done) ? @"YES" : @"NO";
            [body appendFormat:@"<li>%@; done: %@</li>", task.name, doneString];
        }
    }
    else 
    {
        [body appendString:@"<li>No tasks available.</li>"];
    }

    [body appendString:@"</ul>"];
    
    [composer setSubject:title];
    [composer setMessageBody:body isHTML:YES];
    [body release];
    
    [self.navigationController presentModalViewController:composer animated:YES];
    [composer release];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIAccelerometerDelegate method

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    UIAccelerationValue length, x, y, z;
    
    UIAccelerationValue    myAccelerometer[3];
    
    //Use a basic high-pass filter to remove the influence of the gravity
    myAccelerometer[0] = acceleration.x * kFilteringFactor + myAccelerometer[0] * (1.0 - kFilteringFactor);
    myAccelerometer[1] = acceleration.y * kFilteringFactor + myAccelerometer[1] * (1.0 - kFilteringFactor);
    myAccelerometer[2] = acceleration.z * kFilteringFactor + myAccelerometer[2] * (1.0 - kFilteringFactor);
    
    // Compute values for the three axes of the acceleromater
    x = acceleration.x - myAccelerometer[0];
    y = acceleration.y - myAccelerometer[0];
    z = acceleration.z - myAccelerometer[0];
    
    //Compute the intensity of the current acceleration 
    length = sqrt(x * x + y * y + z * z);
    
    // If above a given threshold, shift the index values in the data
    if((length >= kEraseAccelerationThreshold) && (CFAbsoluteTimeGetCurrent() > _lastTime + kMinEraseInterval)) 
    {
        _lastTime = CFAbsoluteTimeGetCurrent();
        RootViewController *rootController = (RootViewController *)[self.navigationController topViewController];
        [rootController shuffleTasks:self];
    }
}

@end
