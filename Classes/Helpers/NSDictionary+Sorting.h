//
//  NSDictionary+Sorting.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Sorting)

- (NSComparisonResult)compareByIndexWith:(NSDictionary *)dict;

@end
