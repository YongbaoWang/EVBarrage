//
//  EVBarrageDisplayViewDelegate.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/6/3.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EVBarrageContainerView;

@protocol EVBarrageContainerViewDelegate <NSObject>

@required
- (UIView *)EVBarrageContainerView:(EVBarrageContainerView *)containerView createDisplayViewForModel:(id<EVBarrageModelProtocol>)model;

- (void)EVBarrageContainerView:(EVBarrageContainerView *)containerView willShowDisplayView:(UIView *)displayView withModel:(id<EVBarrageModelProtocol>)model;

@optional
- (void)EVBarrageContainerView:(EVBarrageContainerView *)containerView didTapDisplayView:(UIView *)displayView withModel:(id<EVBarrageModelProtocol>)model;;

@end

