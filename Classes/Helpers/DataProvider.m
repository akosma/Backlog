//
//  DataProvider.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "DataProvider.h"
#import "SynthesizeSingleton.h"
#import "Task.h"

#define FILE_NAME @"TasksData"

/* 
 Arrange the N elements of ARRAY in random order.
 Only effective if N is much smaller than RAND_MAX;
 if this may not be the case, use a better random
 number generator. 
 This code comes from
 http://benpfaff.org/writings/clc/shuffle.html
*/
static void shuffle(int *array, size_t n)
{
    if (n > 1) 
    {
        size_t i;
        for (i = 0; i < n - 1; i++) 
        {
            size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
            int t = array[j];
            array[j] = array[i];
            array[i] = t;
        }
    }
}

@interface DataProvider (Private)
- (NSString *)dataFilePath;
@end


@implementation DataProvider

SYNTHESIZE_SINGLETON_FOR_CLASS(DataProvider)

@dynamic tasks;

#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init])
    {
        NSString *path = [self dataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            _tasks = [[unarchiver decodeObjectForKey:@"tasks"] retain];
            [unarchiver finishDecoding];
            [unarchiver release];
            [data release];
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
#pragma mark Dynamic property

- (NSArray *)tasks
{
    [_tasks sortUsingSelector:@selector(compareByIndexWith:)];
    return _tasks;
}

#pragma mark -
#pragma mark Public methods

- (void)addTask:(Task *)task
{
    [_tasks addObject:task];
    [self save];
}

- (void)removeTask:(Task *)task
{
    [_tasks removeObject:task];
    [self save];
}

- (void)save
{
    [_tasks sortUsingSelector:@selector(compareByIndexWith:)];
    NSString *path = [self dataFilePath];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_tasks forKey:@"tasks"];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
    [archiver release];
    [data release];
}

- (void)shuffleData
{
    int count = [_tasks count];
    int indexes[count];
    for (int i = 0; i < count; ++i)
    {
        indexes[i] = i;
    }
    shuffle(indexes, count);
    
    for (int i = 0; i < count; ++i)
    {
        Task *task = [_tasks objectAtIndex:i];
        task.index = indexes[i];
    }
    [self save];
}

#pragma mark -
#pragma mark Private methods

- (NSString *)dataFilePath
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [directories lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", directory, FILE_NAME];
    return path;
}

@end
