//
//  EVBarrageDataCenter.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVBarrageModelProtocol.h"

@interface EVBarrageDataCenter : NSObject

/**
 弹幕轨道高度
 */
@property (nonatomic, assign) CGFloat trackHeight;

- (instancetype)init NS_UNAVAILABLE;

//最大可处理弹幕数量
- (instancetype)initWithMaxCapacity:(int)maxCapacity NS_DESIGNATED_INITIALIZER;

- (void)addBarrage:(id<EVBarrageModelProtocol>)model;

- (id<EVBarrageModelProtocol>)nextBarrage;

@end
