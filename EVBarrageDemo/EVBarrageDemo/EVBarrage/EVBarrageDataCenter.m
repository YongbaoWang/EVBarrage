//
//  EVBarrageDataCenter.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageDataCenter.h"

@implementation EVBarrageDataCenter

- (NSArray *)nextMessages {
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 200; i++) {
        [a addObject:@"hello world"];
    }
    return a;
}

@end
