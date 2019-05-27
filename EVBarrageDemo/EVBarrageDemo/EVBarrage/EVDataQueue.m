//
//  EVDataQueue.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/24.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVDataQueue.h"

static const dispatch_time_t TIME_OUT = 2;

@interface EVDataQueue ()
{
    void ** _buffer;
    
    int _front;
    int _rear;
    
    int _maxCapacity;
    dispatch_semaphore_t _semaphore;
}

@end

@implementation EVDataQueue

- (instancetype)initWithMaxCapacity:(int)maxCapacity {
    self = [super init];
    if (self) {
        _maxCapacity = maxCapacity;
        _semaphore = dispatch_semaphore_create(1);
        
        _front = 0;
        _rear = 0;
        
        _buffer = calloc(_maxCapacity, sizeof(void *));
    }
    return self;
}

- (BOOL)isEmpty {
    if (_front == _rear) {
        return YES;
    }
    return NO;
}

- (BOOL)isFull {
    if ((_rear + 1) % _maxCapacity == _front) {
        return YES;
    }
    return NO;
}

- (BOOL)push:(id)obj {
//    dispatch_semaphore_wait(_semaphore, TIME_OUT);
    
    if ([self isFull]) {
//        dispatch_semaphore_signal(_semaphore);
        return NO;
    }
    void *p = (__bridge_retained void *)obj;
    _buffer[_rear % _maxCapacity] = p;
    _rear = (_rear + 1) % _maxCapacity;
    
//    dispatch_semaphore_signal(_semaphore);
    
    return YES;
}

- (id)pop {
//    dispatch_semaphore_wait(_semaphore, TIME_OUT);
    
    if ([self isEmpty]) {
//        dispatch_semaphore_signal(_semaphore);
        return nil;
    }
    void *p = _buffer[_front];
    id obj = (__bridge_transfer id)p;

    _front = (_front + 1) % _maxCapacity;
    
//    dispatch_semaphore_signal(_semaphore);
    
    return obj;
}

- (void)compact {
    
}

- (void)freeAll {
    free(_buffer);
    _buffer = NULL;
}

@end
