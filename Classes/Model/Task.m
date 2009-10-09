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

#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init])
    {
        _name = @"";
        _done = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder 
{
    if (self = [super init])
    {
        _name = [[coder decodeObjectForKey:@"name"] retain];
        _done = [coder decodeBoolForKey:@"done"];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Archiving method

- (void)encodeWithCoder:(NSCoder *)coder 
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeBool:_done forKey:@"done"];
}

@end
