//
//  DataProvider.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface DataProvider : NSObject 
{
@private
    NSMutableArray *_tasks;
    NSString *_dataFilePath;
}

@property (nonatomic, readonly) NSArray *tasks;

+ (DataProvider *)sharedDataProvider;

- (void)addTask;
- (void)removeTask:(Task *)task;
- (void)swapTaskAtIndex:(NSInteger)first withTaskAtIndex:(NSInteger)second;
- (void)shuffleTasks;

@end
