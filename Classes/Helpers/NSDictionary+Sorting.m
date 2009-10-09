//
//  NSDictionary+Sorting.m
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "NSDictionary+Sorting.h"


@implementation NSDictionary (Sorting)

- (NSComparisonResult)compareByIndexWith:(NSDictionary *)dict
{
    NSInteger thisIndex = [[self objectForKey:@"index"] intValue];
    NSInteger otherIndex = [[dict objectForKey:@"index"] intValue];
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

@end
