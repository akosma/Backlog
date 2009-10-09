//
//  DataProvider.h
//  Backlog
//
//  Created by Adrian on 10/7/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DataProvider : NSObject 
{
@private
    NSMutableArray *_tasks;
}

@property (nonatomic, readonly) NSArray *tasks;

+ (DataProvider *)sharedDataProvider;

- (id)init;
- (void)addTask:(NSDictionary *)task;
- (void)removeTask:(NSDictionary *)task;
- (void)save;
- (void)shuffleData;

@end
