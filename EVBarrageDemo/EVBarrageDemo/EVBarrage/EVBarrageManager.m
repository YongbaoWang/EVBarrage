//
//  EVBarrageFactory.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageManager.h"
#import "EVBarrageDisplayView.h"
#import "EVBarrageDataCenter.h"

@interface EVBarrageManager ()

@end

@implementation EVBarrageManager

+ (UIView<EVBarrageDisplayViewProtocol> *)createDisplayView
{
    EVBarrageDisplayView *displayView = [[EVBarrageDisplayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return displayView;
}

+ (id<EVBarrageDataCenterProtocol>)createDataCenter
{
    EVBarrageDataCenter *dataCenter = [[EVBarrageDataCenter alloc] init];
    return dataCenter;
}

@end
