//
//  EVBorderLabel.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/30.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVBorderLabel : UILabel

@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;

@end

NS_ASSUME_NONNULL_END
