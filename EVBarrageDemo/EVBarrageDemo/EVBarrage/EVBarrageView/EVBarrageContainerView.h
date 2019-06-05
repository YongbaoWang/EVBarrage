//
//  EVBarrageDisplayView.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "EVBarrageDataCenter.h"
#import "EVBarrageContainerViewDelegate.h"

@interface EVBarrageContainerView : UIView

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) CGFloat duration;//单条弹幕显示时间
@property (nonatomic, assign) CGFloat areaBegin;//整个弹幕的开始显示区域 0 - 1
@property (nonatomic, assign) CGFloat areaEnd;//整个弹幕的结束显示区域 0 - 1
@property (nonatomic, assign) CGFloat trackHeight; //轨道高度

@property (nonatomic, weak) id<EVBarrageContainerViewDelegate> delegate; //UI代理

@property (nonatomic, strong) EVBarrageDataCenter *dataCenter; //数据中心

- (void)start;//开启弹幕

- (void)stop;//关闭弹幕

@end
