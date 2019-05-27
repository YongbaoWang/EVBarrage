//
//  EVBarrageDisplayView.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageDisplayView.h"

@interface EVBarrageDisplayView ()

@property (nonatomic, strong) NSMutableArray *reuseArrayM;
@property (nonatomic, strong) dispatch_queue_t serialQueue;

@property (nonatomic, strong) NSMutableArray *waitToDisplayArrayM;

@end

@implementation EVBarrageDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOrientationDidChangeNotificaiton) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleOrientationDidChangeNotificaiton{
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
//    self.frame =
}

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.serialQueue = dispatch_queue_create("com.ever.evbarrage", DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 5000; i++) {
        [self createOneMessageContainer];
    }
}

- (UILabel *)createOneMessageContainer {
    UILabel *msgLbl = [[UILabel alloc] init];
    msgLbl.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self addSubview:msgLbl];
    
    [self resetOneMessageContainerState:msgLbl];
    
    [self.reuseArrayM addObject:msgLbl];
    
    return msgLbl;
}

- (void)resetOneMessageContainerState:(UILabel *)lbl {
    lbl.frame = CGRectMake(self.bounds.size.width, arc4random()%(int)self.bounds.size.height, 0, 0);
}

- (void)start {
    [self performSelector:@selector(test) withObject:nil afterDelay:1];
}

- (void)test {
    [self runDisplay];
}

- (void)runDisplay {
    [self.waitToDisplayArrayM addObjectsFromArray:[self.dataSource nextMessages]];
    [self.waitToDisplayArrayM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAttributedString *msg = [[NSAttributedString alloc] initWithString:obj];
        CGRect rect = [msg boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        UILabel *msgLbl = [self popOneValidMessageContainer];
        if (msgLbl == nil) {
            msgLbl = [self createOneMessageContainer];
        }
        CGRect msgRect = msgLbl.frame;
        msgRect.size.width = rect.size.width;
        msgRect.size.height = rect.size.height;
        
        msgLbl.frame = msgRect;
        
        [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            msgLbl.center = CGPointMake(msgLbl.center.x - self.bounds.size.width - msgLbl.frame.size.width, msgLbl.center.y);
        } completion:^(BOOL finished) {
            [self pushOneValudMessageContainer:msgLbl];
        }];
    }];
    
    [self performSelector:@selector(runDisplay) withObject:nil afterDelay:1];
}

- (UILabel *)popOneValidMessageContainer {
    UILabel *lbl = self.reuseArrayM.firstObject;
    [self.reuseArrayM removeObject:lbl];
    return lbl;
}

- (void)pushOneValudMessageContainer:(UILabel *)lbl {
    [self resetOneMessageContainerState:lbl];
    [self.reuseArrayM addObject:lbl];
}

#pragma mark - Property
- (NSMutableArray *)reuseArrayM {
    if (!_reuseArrayM) {
        _reuseArrayM = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _reuseArrayM;
}

- (NSMutableArray *)waitToDisplayArrayM {
    if (!_waitToDisplayArrayM) {
        _waitToDisplayArrayM = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _waitToDisplayArrayM;
}

@end
