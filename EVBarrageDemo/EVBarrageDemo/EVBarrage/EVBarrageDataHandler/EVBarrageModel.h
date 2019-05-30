//
//  EVBarrageModel.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVBarrageModelProtocol.h"

@interface EVBarrageModel : NSObject<EVBarrageModelProtocol>

@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) NSAttributedString *text;
@property (nonatomic, assign) EVBarragePriority priority;

/**
 弹幕开始位置（无需赋值，内部会自动计算）
 */
@property (nonatomic, assign) CGRect startFrame;

/**
 弹幕结束位置（无需赋值，内部会自动计算）
 */
@property (nonatomic, assign) CGRect endFrame;

/**
 弹幕延时显示时长（无需赋值，内部会自动计算），如果没有延时，则会和前一个弹幕显示重叠
 */
@property (nonatomic, assign) CGFloat delay;

/**
 弹幕显示耗时，单位：秒（无需赋值，内部会自动计算）；一个弹幕，从出现到消失 的总耗时
 */
@property (nonatomic, assign) CGFloat duration;

@end

