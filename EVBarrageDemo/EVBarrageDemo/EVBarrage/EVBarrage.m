//
//  EVBarrage.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrage.h"
#import "EVBarrageContainerView.h"
#import "EVBarrageDataCenter.h"

@interface EVBarrage ()
{
    CGRect _containerViewFrame;
}

@property (nonatomic, strong) EVBarrageDataCenter *dataCenter;

@end

@implementation EVBarrage

@synthesize containerView = _containerView;

#pragma mark - INIT 
- (instancetype)initWithContainerViewFrame:(CGRect)frame containerViewDelegate:(id<EVBarrageContainerViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _duration = 12;
        _areaBegin = 0.05;
        _areaEnd = 1;
        _trackHeight = 30;
        _maxCapacity = 1000000;
        _delegate = delegate;
        _containerViewFrame = frame;
    }
    return self;
}

#pragma mark - PUBLIC API
- (void)addBarrage:(id<EVBarrageModelProtocol>)model {
    [self.dataCenter addBarrage:model];
}

- (void)start {
    [self.containerView start];
}

- (void)stop {
    [self.containerView stop];
}

#pragma mark - PROPERTY
- (EVBarrageContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[EVBarrageContainerView alloc] initWithFrame:_containerViewFrame];
        _containerView.duration = self.duration;
        _containerView.areaBegin = self.areaBegin;
        _containerView.areaEnd = self.areaEnd;
        _containerView.trackHeight = self.trackHeight;
        _containerView.delegate = self.delegate;
        _containerView.dataCenter = self.dataCenter;
    }
    return _containerView;
}

- (EVBarrageDataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[EVBarrageDataCenter alloc] initWithMaxCapacity:_maxCapacity];
    }
    return _dataCenter;
}

- (void)setAreaBegin:(CGFloat)areaBegin {
    if (areaBegin >= 1) {
        NSAssert(false, @"areaBegin can't be more than 1.");
    }
    _areaBegin = areaBegin;
}

- (void)setAreaEnd:(CGFloat)areaEnd {
    if (areaEnd <= 0) {
        NSAssert(false, @"areaEnd can't be less than 0.");
    }
    _areaEnd = areaEnd;
}

- (void)setMaxCapacity:(int)maxCapacity {
    _maxCapacity = maxCapacity;
    _dataCenter.maxCapacity = _maxCapacity;
}

@end
