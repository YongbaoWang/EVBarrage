//
//  EVBarrageModelProtocol.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger, EVBarragePriority) {
    EVBarragePriorityLowest,
    EVBarragePriorityLower,
    EVBarragePriorityLow,
    EVBarragePriorityNormal,
    EVBarragePriorityHigh,
    EVBarragePriorityHigher,
    EVBarragePriorityHighest,
};

@protocol EVBarrageModelProtocol <NSObject>

/**
 可重用标记；如果是相同UI的弹幕类型，请使用相同的reuseIdentifier
 */
@property (nonatomic, copy) NSString *reuseIdentifier;

/**
 弹幕文本
 */
@property (nonatomic, copy) NSAttributedString *text;

/**
 弹幕优先级（当弹幕数量巨大时，低优先级的弹幕可能会被丢弃）
 */
@property (nonatomic, assign) EVBarragePriority priority;

/**
 是否支持点击
 */
@property (nonatomic, assign, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;


//========以下属性，无需赋值
//====================================================

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
