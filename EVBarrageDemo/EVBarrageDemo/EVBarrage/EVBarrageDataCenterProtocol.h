//
//  EVBarrageDataSource.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EVBarrageDataCenterProtocol <NSObject>

@required
- (NSArray *)nextMessages;

@end

