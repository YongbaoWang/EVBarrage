//
//  EVBarrage.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrage.h"
#import "EVBarrageDisplayView.h"
#import "EVBarrageDataCenter.h"

@interface EVBarrage ()

@property (nonatomic, strong) EVBarrageDisplayView *containerView;
@property (nonatomic, strong) EVBarrageDataCenter *dataCenter;

@end

@implementation EVBarrage

- (instancetype)initWithDisplayViewFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _fontSize = 16;
        _alpha = 1;
        _duration = 8;
        _areaBegin = 0.1;
        _areaEnd = 1;
    }
    return self;
}

- (UIView *)displayView {
    return self.containerView;
}

- (void)addBarrage:(id<EVBarrageModelProtocol>)model {
    [self.dataCenter addBarrage:model];
}

- (void)start {
    [self.containerView start];
}

- (void)stop {
    [self.containerView stop];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[EVBarrageDisplayView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _containerView.dataCenter = self.dataCenter;
    }
    return _containerView;
}

- (EVBarrageDataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[EVBarrageDataCenter alloc] initWithMaxCapacity:10000000];
    }
    return _dataCenter;
}

@end
