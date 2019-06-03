//
//  EVBarrageDisplayView.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/29.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "EVBarrageDisplayView.h"
#import "EVBorderLabel.h"

#define EV_BARRAGE_MAIN_THREAD \
if (![NSThread isMainThread]) { \
NSAssert(false, @"You should invoke this method in the main thread!"); \
}

#define EV_BARRAGE_OTHER_THREAD \
if ([NSThread isMainThread]) { \
    NSAssert(false, @"You shouldn't invoke this method in the main thread!"); \
}

@interface EVBarrageDisplayView ()
{
    CGSize _viewSize;
}

@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation EVBarrageDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _viewSize = frame.size;
        _fontSize = 20;
        _alpha = 1;
        _duration = 8;
        _areaBegin = 0.15;
        _areaEnd = 0.9;
        _trackHeight = 30;
        _trackCount = floor(frame.size.height * (_areaEnd - _areaBegin) / _trackHeight);
        
//        _trackCount = 1;
        
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)start {
    [self resetAllTrackOperation];
}

- (void)stop {
    [self.operationQueue cancelAllOperations];
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

    CGFloat minIntervalBetweenTwoBarrage = 44; //两个弹幕之间的最小距离
    CGFloat minTextWidth = 120 ; //弹幕的最小宽度
    
    while (YES) {
        id<EVBarrageModelProtocol> model = [self.dataCenter nextBarrage];
        if (model != nil) {
//            CGSize size = [model.text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
            CGSize size = [model.text.string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]} context:nil].size;
            
            if (size.width < minTextWidth) {
                size.width = minTextWidth;
            }
            
            model.startFrame = CGRectMake(x, y, size.width, height);
            model.endFrame = CGRectMake(-size.width, y, size.width, height);
            model.duration = self.duration;
            
            model.delay = (size.width + minIntervalBetweenTwoBarrage + arc4random()%40) / ((x + size.width)/model.duration);
            
            [self animateViewWithModel:model];
            
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
        
        [UIView animateWithDuration:model.duration delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionPreferredFramesPerSecond60 animations:^{
            view.frame = model.endFrame;
        } completion:^(BOOL finished) {
            [self saveReuseView:view withModel:model];
        }];
    });
}

- (UIView *)reuseViewWithModel:(id<EVBarrageModelProtocol>)model {
    EV_BARRAGE_MAIN_THREAD
    
    NSMutableArray *arrM = self.cache[model.reuseIdentifier];
    if (arrM == nil) {
        arrM = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    UILabel *lbl = [arrM lastObject];
    [arrM removeLastObject];
    
    if (lbl == nil) {
        lbl = [self createLabel];
    }
    lbl.attributedText = model.text;
    
    self.cache[model.reuseIdentifier] = arrM;
    
    return lbl;
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

- (UILabel *)createLabel {
    EV_BARRAGE_MAIN_THREAD
    
    EVBorderLabel *label = [[EVBorderLabel alloc] init];
    label.font = [UIFont systemFontOfSize:self.fontSize];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.strokeWidth = 1;
    label.strokeColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    return label;
}

- (NSMutableDictionary *)cache {
    if (!_cache) {
        _cache = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _cache;
}

@end
