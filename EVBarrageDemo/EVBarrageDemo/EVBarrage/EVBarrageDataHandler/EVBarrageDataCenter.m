//
//  EVBarrageDataCenter.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageDataCenter.h"
#import "EVDataQueue.h"
#import <UIKit/UIKit.h>

@interface EVBarrageDataCenter ()

@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *lowestQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *lowerQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *lowQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *normalQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *highQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *higherQueue;
@property (nonatomic, strong) EVDataQueue<id<EVBarrageModelProtocol>> *highestQueue;

@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@property (nonatomic, assign) int maxCapacity;

@end

@implementation EVBarrageDataCenter

- (instancetype)initWithMaxCapacity:(int)maxCapacity {
    self = [super init];
    if (self) {
        self.maxCapacity = maxCapacity;
        _concurrentQueue = dispatch_queue_create("com.eversoft.evbarrage", DISPATCH_QUEUE_CONCURRENT);
        
        _lowestQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _lowerQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _lowQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _normalQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _highQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _higherQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
        _highestQueue = [[EVDataQueue alloc] initWithMaxCapacity:self.maxCapacity];
    }
    return self;
}

- (void)addBarrage:(id<EVBarrageModelProtocol>)model {
    dispatch_async(self.concurrentQueue, ^{
        long usedCapacity = self.lowestQueue.size + self.lowerQueue.size + self.lowQueue.size + self.normalQueue.size + self.highQueue.size + self.higherQueue.size + self.highestQueue.size;
        if (usedCapacity >= self.maxCapacity) {
#warning 通知最大容量
            NSLog(@"弹幕已达到最大容量!");
            return;
        }
        
        EVDataQueue<id<EVBarrageModelProtocol>> *dataQueue = [self dataQueueByBarragePriority:model.priority];
        [dataQueue enqueue:model];
    });
}

- (EVDataQueue<id<EVBarrageModelProtocol>> *)dataQueueByBarragePriority:(EVBarragePriority)priority {
    EVDataQueue<id<EVBarrageModelProtocol>> *dataQueue = nil;
    switch (priority) {
        case EVBarragePriorityLowest:
            dataQueue = self.lowestQueue;
            break;
        case EVBarragePriorityLower:
            dataQueue = self.lowerQueue;
            break;
        case EVBarragePriorityLow:
            dataQueue = self.lowQueue;
            break;
        case EVBarragePriorityNormal:
            dataQueue = self.normalQueue;
            break;
        case EVBarragePriorityHigh:
            dataQueue = self.highQueue;
            break;
        case EVBarragePriorityHigher:
            dataQueue = self.higherQueue;
            break;
        case EVBarragePriorityHighest:
            dataQueue = self.highestQueue;
            break;
    }
    return dataQueue;
}

#define EVBarrageValidNext(queue) \
if (queue.size > 0) { \
    model = [queue dequeue]; \
    if (model != nil) { \
        return model; \
    } \
}

- (id<EVBarrageModelProtocol>)nextBarrage {
    id<EVBarrageModelProtocol> model = nil;
    
    EVBarrageValidNext(self.highestQueue)
    EVBarrageValidNext(self.higherQueue)
    EVBarrageValidNext(self.highQueue)
    EVBarrageValidNext(self.normalQueue)
    EVBarrageValidNext(self.lowQueue)
    EVBarrageValidNext(self.lowerQueue)
    EVBarrageValidNext(self.lowestQueue)
    
    return nil;
}

#undef EVBarrageValidNext

@end
