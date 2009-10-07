//
//  DataProvider.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DataProvider : NSObject 
{
@private
    NSMutableArray *_tasks;
}

+ (DataProvider *)sharedDataProvider;

- (id)init;
- (void)addTask:(NSDictionary *)task;
- (void)removeTask:(NSDictionary *)task;
- (NSArray *)tasks;
- (void)save;
- (void)shuffleData;

@end
