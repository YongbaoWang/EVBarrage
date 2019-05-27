//
//  EVDataQueue.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/24.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVDataQueue<ElementType> : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithMaxCapacity:(int)maxCapacity NS_DESIGNATED_INITIALIZER;

- (BOOL)push:(ElementType)obj;

- (ElementType)pop;

- (BOOL)isEmpty;

- (BOOL)isFull;

- (void)freeAll;

@end

