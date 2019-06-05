//
//  EVBarrageModel.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageModel.h"
#import <UIKit/UIKit.h>

 NSString * const EVBarrageReuseIdentity_MY = @"EVBarrageReuseIdentity_MY";
 NSString * const EVBarrageReuseIdentity_VIP = @"EVBarrageReuseIdentity_VIP";
 NSString * const EVBarrageReuseIdentity_NORMAL = @"EVBarrageReuseIdentity_NORMAL";

@implementation EVBarrageModel

- (NSMutableAttributedString *)createAttributedStringWithString:(NSString *)string fontSize:(CGFloat)fontSize {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, string.length)];
    return attr;
}

@end
