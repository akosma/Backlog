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
- (void)save;
@end


@implementation DataProvider

SYNTHESIZE_SINGLETON_FOR_CLASS(DataProvider)

@synthesize tasks = _tasks;

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
    [_dataFilePath release];
    [_tasks release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (NSInteger)count
{
    return [_tasks count];
}

- (Task *)taskAtIndex:(NSInteger)index
{
    Task *task = [_tasks objectAtIndex:index];
    [task addObserver:self forKeyPath:@"name" options:0 context:NULL];
    [task addObserver:self forKeyPath:@"done" options:0 context:NULL];

    return task;
}

- (void)addTask
{
    NSInteger count = [_tasks count] + 1;
    NSString *taskName = [NSString stringWithFormat:@"Task %d", count];
    Task *task = [[Task alloc] init];
    task.name = taskName;
    task.done = NO;

    [task addObserver:self forKeyPath:@"name" options:0 context:NULL];
    [task addObserver:self forKeyPath:@"done" options:0 context:NULL];

    [_tasks addObject:task];
    [task release];
    [self save];
}

- (void)removeTask:(Task *)task
{
    [task removeObserver:self forKeyPath:@"name"];
    [task removeObserver:self forKeyPath:@"done"];
    [_tasks removeObject:task];
    [self save];
}

- (void)swapTaskAtIndex:(NSInteger)first withTaskAtIndex:(NSInteger)second
{
    [_tasks exchangeObjectAtIndex:first withObjectAtIndex:second];
    [self save];
}

- (void)shuffleTasks
{
    // This code comes from
    // http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
    NSUInteger count = [_tasks count];
    for (NSUInteger i = 0; i < count; ++i) 
    {
        int nElements = count - i;
        int n = (random() % nElements) + i;
        [_tasks exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    [self save];
}

#pragma mark -
#pragma mark KVO delegate method

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    [self save];
}

#pragma mark -
#pragma mark Private methods

- (void)save
{
    NSString *path = [self dataFilePath];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_tasks forKey:@"tasks"];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
    [archiver release];
    [data release];
}

- (NSString *)dataFilePath
{
    if (_dataFilePath == nil)
    {
        NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *directory = [directories lastObject];
        _dataFilePath = [[NSString alloc] initWithFormat:@"%@/%@", directory, FILE_NAME];
    }
    return _dataFilePath;
}

@end
