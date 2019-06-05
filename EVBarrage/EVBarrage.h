//
//  EVBarrage.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "EVBarrageModelProtocol.h"
#import "EVBarrageModel.h"
#import "EVBarrageContainerViewDelegate.h"
#import "EVBarrageContainerView.h"

/*
 不透明度 0 - 100
 字号
 弹幕速度 4s - 20s
 显示区域 10-100  1 - 9行
 按位置屏蔽 顶部弹幕、底部弹幕、字幕区域
 按类型屏蔽 彩色文字、红包弹幕、上榜弹幕
 自定义屏蔽
 支持弹幕点击事件
 支持居中弹幕
 支持弹幕带有用户头像、表情
 支持弹幕 字体颜色
 自己发送的弹幕，有圆角边框
 */


@interface EVBarrage : NSObject

/**
 单条弹幕从出现到消失，总耗时：* 秒。默认：12s
 */
@property (nonatomic, assign) CGFloat duration;

/**
 所有弹幕的开始显示范围。默认0.05。即：假设屏幕高度为 100 px，单条弹幕的最小Y坐标为 10 px。
 */
@property (nonatomic, assign) CGFloat areaBegin;

/**
 所有弹幕的最终显示范围。默认1。【如果只需要屏幕上半部分显示弹幕，则可以设置此值为 0.5】
 */
@property (nonatomic, assign) CGFloat areaEnd;

/**
 轨道高度，即单行弹幕的视图高度，默认 30.
 */
@property (nonatomic, assign) CGFloat trackHeight;

/**
 最大可处理弹幕数量，超过该数量，将丢弃低优先级弹幕
 */
@property (nonatomic, assign) int maxCapacity;

/**
 弹幕容器代理
 */
@property (nonatomic, weak, readonly) id<EVBarrageContainerViewDelegate> delegate;

/**
 弹幕容器视图
 */
@property (nonatomic, strong, readonly) EVBarrageContainerView *containerView;

- (instancetype)init NS_UNAVAILABLE;

/**
 初始化方法

 @param frame 弹幕容器frame
 @param delegate 弹幕容器代理
 @return EVBarrage
 */
- (instancetype)initWithContainerViewFrame:(CGRect)frame containerViewDelegate:(id<EVBarrageContainerViewDelegate>) delegate NS_DESIGNATED_INITIALIZER;

/**
 添加一条弹幕

 @param model 弹幕model
 */
- (void)addBarrage:(id<EVBarrageModelProtocol>)model;

/**
 设置完毕后，开始运行弹幕
 */
- (void)start;

/**
 停止弹幕，停止后，将清空所有弹幕，已显示的弹幕，将直接从屏幕移除
 */
- (void)stop;

@end
