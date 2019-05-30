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

@interface EVBarrageDisplayView : UIView

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat areaBegin;
@property (nonatomic, assign) CGFloat trackCount; //轨道数量
@property (nonatomic, assign) CGFloat trackHeight; //轨道高度

@property (nonatomic, strong) EVBarrageDataCenter *dataCenter; //数据中心

- (void)start;

- (void)stop;

@end
