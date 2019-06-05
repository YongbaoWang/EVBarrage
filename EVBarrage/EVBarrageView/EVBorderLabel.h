//
//  EVBorderLabel.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/30.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "EVBarrageModelProtocol.h"

@interface EVBorderLabel : UILabel

@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong) id<EVBarrageModelProtocol> model;

@end
