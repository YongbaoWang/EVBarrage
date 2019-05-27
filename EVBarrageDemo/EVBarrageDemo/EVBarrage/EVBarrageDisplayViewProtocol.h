//
//  EVBarrageDisplayViewProtocol.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVBarrageDataCenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EVBarrageDisplayViewProtocol <NSObject>

@property (nonatomic, weak) id<EVBarrageDataCenterProtocol> dataSource;

- (void)start;

@end

NS_ASSUME_NONNULL_END
