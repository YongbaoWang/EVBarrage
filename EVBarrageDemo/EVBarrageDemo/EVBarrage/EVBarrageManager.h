//
//  EVBarrageFactory.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EVBarrageDisplayViewProtocol.h"
#import "EVBarrageDataCenterProtocol.h"

@interface EVBarrageManager : NSObject

+ (UIView<EVBarrageDisplayViewProtocol> *)createDisplayView;

+ (id<EVBarrageDataCenterProtocol>)createDataCenter;

@end


