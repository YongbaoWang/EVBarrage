//
//  EVBarrageDisplayView.h
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVBarrageDataCenterProtocol.h"
#import "EVBarrageDisplayViewProtocol.h"

@interface EVBarrageDisplayView : UIView<EVBarrageDisplayViewProtocol>

@property (nonatomic, weak) id<EVBarrageDataCenterProtocol> dataSource;

@end

