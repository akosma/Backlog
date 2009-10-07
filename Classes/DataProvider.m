//
//  DataProvider.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DataProvider.h"
#import "SynthesizeSingleton.h"

#define FILE_NAME @"TasksData"

@interface DataProvider (Private)
- (NSString *)dataFilePath;
@end


@implementation DataProvider

SYNTHESIZE_SINGLETON_FOR_CLASS(DataProvider)

#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init])
    {
        NSString *path = [self dataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            _tasks = [[NSMutableArray arrayWithContentsOfFile:path] retain];
        }
        else 
        {
            _tasks = [[NSMutableArray alloc] init];
            [self save];
        }

    }
    return self;
}

- (void)dealloc
{
    [_tasks release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (NSArray *)tasks
{
    return _tasks;
}

- (void)addTask:(NSDictionary *)task
{
    [_tasks addObject:task];
    [self save];
}

- (void)removeTask:(NSDictionary *)task
{
    [_tasks removeObject:task];
    [self save];
}

- (void)save
{
    NSString *path = [self dataFilePath];
    [_tasks writeToFile:path atomically:NO];
}

- (NSString *)dataFilePath
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [directories lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", directory, FILE_NAME];
	return path;
}

@end
