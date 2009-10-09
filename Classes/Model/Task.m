//
//  Task.m
//  Backlog
//
//  Created by Adrian on 10/9/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize name = _name;
@synthesize done = _done;
@synthesize index = _index;

#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init])
    {
        _name = @"";
        _done = NO;
        _index = -1;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder 
{
    if (self = [super init])
    {
        _name = [[coder decodeObjectForKey:@"name"] retain];
        _done = [coder decodeBoolForKey:@"done"];
        _index = [coder decodeIntForKey:@"index"];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public method

- (NSComparisonResult)compareByIndexWith:(Task *)task
{
    NSInteger thisIndex = self.index;
    NSInteger otherIndex = task.index;
    if (thisIndex > otherIndex)
    {
        return NSOrderedAscending;
    }
    if (thisIndex < otherIndex)
    {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

#pragma mark -
#pragma mark Archiving method

- (void)encodeWithCoder:(NSCoder *)coder 
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeBool:_done forKey:@"done"];
    [coder encodeInt:_index forKey:@"index"];
}

@end
