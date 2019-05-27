//
//  EVDataQueue.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/24.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVDataQueue.h"

@interface EVQueueNode : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, strong) id next;

@end

@implementation EVQueueNode

@end

static const dispatch_time_t TIME_OUT = 0.5; //信号量超时时间(单位：s)

@interface EVDataQueue ()
{
//    void ** _buffer; //二级指针，用来保存队列中所有的对象指针
    
    
    
    EVQueueNode * _front; //指向对首
    EVQueueNode * _rear; //指向对尾
    
    int _currentCapacity; //当前队列最大容量
    int _maxCapacity; //当前队列最大可扩展容量
    dispatch_semaphore_t _semaphore; //信号量，用来保证线程安全
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
        
        _currentCapacity = 100;
        if (_currentCapacity >= _maxCapacity) {
            _currentCapacity = _maxCapacity;
        }
//        _buffer = calloc(_currentCapacity, sizeof(void *));
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
//    if ((_rear + 1) % _maxCapacity == _front) {
//        return YES;
//    }
    return NO;
}

- (BOOL)push:(id)obj {
//    dispatch_semaphore_wait(_semaphore, TIME_OUT);
    
    if ([self isFull]) {
//        dispatch_semaphore_signal(_semaphore);
        return NO;
    }
//    void *p = (__bridge_retained void *)obj;
//    _buffer[_rear % _maxCapacity] = p;
//    _rear = (_rear + 1) % _maxCapacity;
    
    EVQueueNode *node = [EVQueueNode new];
    node.value = obj;
    node.next = nil;
    
    _rear.next = node;
    _rear = node;
    
    if (_front == nil) {
        _front = node;
    }
        
//    dispatch_semaphore_signal(_semaphore);
    
    return YES;
}

- (id)pop {
//    dispatch_semaphore_wait(_semaphore, TIME_OUT);
    
    if ([self isEmpty]) {
//        dispatch_semaphore_signal(_semaphore);
        return nil;
    }
//    void *p = _buffer[_front];
//    id obj = (__bridge_transfer id)p;
//
//    _front = (_front + 1) % _maxCapacity;
    
    id obj = _front.value;
    _front = _front.next;
    
//    dispatch_semaphore_signal(_semaphore);
    
    return obj;
}

- (void)compact {
    
}

- (void)freeAll {
//    free(_buffer);
//    _buffer = NULL;
    
    _front = nil;
    _rear = nil;
}

@end
