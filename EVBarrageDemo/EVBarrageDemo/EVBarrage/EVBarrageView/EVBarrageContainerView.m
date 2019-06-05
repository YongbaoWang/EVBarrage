//
//  EVBarrageDisplayView.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageContainerView.h"
#import "EVBorderLabel.h"
#import <objc/runtime.h>

#define EV_BARRAGE_MAIN_THREAD \
if (![NSThread isMainThread]) { \
NSAssert(false, @"You should invoke this method in the main thread!"); \
}

#define EV_BARRAGE_OTHER_THREAD \
if ([NSThread isMainThread]) { \
    NSAssert(false, @"You shouldn't invoke this method in the main thread!"); \
}

@interface EVBarrageContainerView ()
{
    CGSize _viewSize;
    CGFloat _minIntervalBetweenTwoBarrage; //两个弹幕之间的最小距离
    CGFloat _minTextWidth; //弹幕的最小宽度
}

@property (nonatomic, assign) CGFloat trackCount; //轨道数量

@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation EVBarrageContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _minIntervalBetweenTwoBarrage = 60;
        _minTextWidth = 100;
        _viewSize = frame.size;
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}


- (void)start {
    [self resetAllTrackOperation];
}

- (void)stop {
    [self.operationQueue cancelAllOperations];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.dataCenter clearAll];
}

- (void)resetAllTrackOperation {
    [self.operationQueue cancelAllOperations];
    self.operationQueue.maxConcurrentOperationCount = self.trackCount;
    
    for (int i = 0; i < self.trackCount; i++) {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(startTrack:) object:@(i)];
        [self.operationQueue addOperation:operation];
    }
}

- (void)startTrack:(NSNumber *)trackIndex {
    EV_BARRAGE_OTHER_THREAD
    
    CGFloat x = _viewSize.width;
    CGFloat height = self.trackHeight;
    CGFloat y = _viewSize.height * self.areaBegin + height * trackIndex.intValue;
    CGFloat lastTextWidth = MAXFLOAT;
    
    while (YES) {
        id<EVBarrageModelProtocol> model = [self.dataCenter nextBarrage];
        if (model != nil) {
            CGSize size = [model.text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
            
            model.startFrame = CGRectMake(x, y, size.width, height);
            model.endFrame = CGRectMake(-size.width, y, size.width, height);
            model.duration = self.duration;
            
            if (size.width < _minTextWidth) {
                size.width = _minTextWidth;
            }
            
            CGFloat lastSpeed = ((x + lastTextWidth)/model.duration);
            CGFloat currentSpeed = ((x + size.width)/model.duration);
            
            model.delay = (size.width + _minIntervalBetweenTwoBarrage) / currentSpeed;
            
            //后一个弹幕比前一个弹幕 长度越长（这意味着后一个弹幕速度比第一个快），则 两者之间间距越大
            if (size.width/lastTextWidth > 1.5) {
                CGFloat offset = size.width/lastTextWidth * 80;
                CGFloat moreDelayBeforeAni = offset/currentSpeed;
                sleep(moreDelayBeforeAni);
            }

            [self animateViewWithModel:model];
            
            lastTextWidth = size.width;
            
            sleep(model.delay);
        } else {
            sleep(arc4random()%3 + 3);
        }
    }
}

- (void)animateViewWithModel:(id<EVBarrageModelProtocol>)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [self reuseViewWithModel:model];
        view.frame = model.startFrame;
        
        UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionPreferredFramesPerSecond60;
        if (model.isUserInteractionEnabled) {
            options |= UIViewAnimationOptionAllowUserInteraction;
        }

        [UIView animateWithDuration:model.duration delay:0 options:options animations:^{
            view.frame = model.endFrame;
        } completion:^(BOOL finished) {
            [self saveReuseView:view withModel:model];
        }];
        
//        CGFloat timeInterval = 0.02;
//        CGFloat stepSize = (model.startFrame.origin.x - model.endFrame.origin.x)/(model.duration/timeInterval);
//
//        [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
//            CGRect frame = view.frame;
//            frame.origin.x -= stepSize;
//            view.frame = frame;
//            if (view.frame.origin.x < model.endFrame.origin.x) {
//                [timer invalidate];
//            }
//            NSLog(@"aa");
//        }];
    });
}

- (UIView *)reuseViewWithModel:(id<EVBarrageModelProtocol>)model {
    EV_BARRAGE_MAIN_THREAD
    
    NSMutableArray *arrM = self.cache[model.reuseIdentifier];
    if (arrM == nil) {
        arrM = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    UIView *view = [arrM lastObject];
    [arrM removeLastObject];
    
    if (view == nil) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(EVBarrageContainerView:createDisplayViewForModel:)]) {
            view = [self.delegate EVBarrageContainerView:self createDisplayViewForModel:model];
            NSAssert(view != nil, @"EVBarrageContainerView:displayViewForModel: can't be nil.");
            [self addSubview:view];
            
            if (model.isUserInteractionEnabled) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayViewTapAction:)];
                [view addGestureRecognizer:tap];
            }
        }
    }
    
    if (model.isUserInteractionEnabled) {
        view.userInteractionEnabled = YES;
        objc_setAssociatedObject(view, @selector(reuseViewWithModel:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        view.userInteractionEnabled = NO;
        objc_setAssociatedObject(view, @selector(reuseViewWithModel:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(EVBarrageContainerView:willShowDisplayView:withModel:)]) {
        [self.delegate EVBarrageContainerView:self willShowDisplayView:view withModel:model];
    }
    
    self.cache[model.reuseIdentifier] = arrM;
    
    return view;
}

- (void)saveReuseView:(UIView *)view withModel:(id<EVBarrageModelProtocol>)model {
    EV_BARRAGE_MAIN_THREAD
    
    NSMutableArray *arrM = self.cache[model.reuseIdentifier];
    if (arrM == nil) {
        arrM = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [arrM addObject:view];
    self.cache[model.reuseIdentifier] = arrM;
}

- (void)displayViewTapAction:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
    id obj = objc_getAssociatedObject(view, @selector(reuseViewWithModel:));
    if ([obj conformsToProtocol:@protocol(EVBarrageModelProtocol)]) {
        id<EVBarrageModelProtocol> model = (id<EVBarrageModelProtocol>)obj;
        if (self.delegate && [self.delegate respondsToSelector:@selector(EVBarrageContainerView:didTapDisplayView:withModel:)]) {
            [self.delegate EVBarrageContainerView:self didTapDisplayView:view withModel:model];
        }
    }
}


#pragma mark - PROPERTY

- (NSMutableDictionary *)cache {
    if (!_cache) {
        _cache = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _cache;
}

- (void)setTrackHeight:(CGFloat)trackHeight {
    _trackHeight = trackHeight;
    _trackCount = floor(_viewSize.height * (_areaEnd - _areaBegin) / _trackHeight);
    
//    _trackCount = 1;
}

@end
