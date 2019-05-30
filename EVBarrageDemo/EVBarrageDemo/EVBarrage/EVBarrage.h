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
#import "EVBarrageDataHandler/EVBarrageModelProtocol.h"
#import "EVBarrageModel.h"

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

NS_ASSUME_NONNULL_BEGIN

@interface EVBarrage : NSObject

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat areaBegin;
@property (nonatomic, assign) CGFloat areaEnd;

- (UIView *)displayView;

- (void)addBarrage:(id<EVBarrageModelProtocol>)model;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
