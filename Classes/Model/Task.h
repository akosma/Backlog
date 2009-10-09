//
//  Task.h
//  Backlog
//
//  Created by Adrian on 10/9/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject <NSCoding>
{
@private
    NSString *_name;
    BOOL _done;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) BOOL done;

@end
