//
//  ViewController.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "ViewController.h"
#import "EVBarrage.h"
#import "EVDataQueue.h"
#import "EVBorderLabel.h"

@interface ViewController ()<EVBarrageContainerViewDelegate>

@property (nonatomic, strong) EVBarrage *barrage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //假设我们正在播放一个视频 。。。
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"bg"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    //初始化弹幕控件
    self.barrage = [[EVBarrage alloc] initWithContainerViewFrame:self.view.bounds containerViewDelegate:self];
    self.barrage.duration = 10;
    //将弹幕视图添加到播放器视图上
    [imgView addSubview:self.barrage.containerView];

    //开启弹幕
    [self.barrage start];

    //假数据，随机添加50w条弹幕
    [self addBarrage];
}

- (void)addBarrage {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *reuseArray = @[EVBarrageReuseIdentity_MY,EVBarrageReuseIdentity_VIP,EVBarrageReuseIdentity_NORMAL];
        
        for (int i = 0; i < 200000; i++) {
            EVBarrageModel *model = [EVBarrageModel new];
            model.reuseIdentifier = i % 10 == 0 ? reuseArray[0] : (i % 8 == 0 ? reuseArray[1] : reuseArray[2]);
            NSString *str = [self randomCreatChinese:i];
            model.text = [model createAttributedStringWithString:str fontSize:20];
            model.priority = EVBarragePriorityLow;
            model.userInteractionEnabled = YES;

            [self.barrage addBarrage:model];
        }
    });
}

- (NSMutableString*)randomCreatChinese:(NSInteger)count{
    NSArray *content = @[@"这个杜少乾还挺讲究，我还以为他会自己独揽功劳呢，不愧是我们大东带出来的弟弟",
//                         @"这小两口开锁换图纸太可爱啦，无意中扮个鬼脸😜",
//                         @"沈其南不愧是在社会上摸爬滚打这么多年出来的男人",
//                         @"沈其南太可爱了，看到自己的情敌穿的一身西服像模像样的出入，当然忍不住想恶搞他",
//                         @"这集也太甜了吧",
//                         @"对于沈其南来说，除了自己的父母兄弟，就只有傅函君是他关心的人了",
//                         @"女强人",
//                         @"太喜欢霍建华",
//                         @"杨幂真的好漂亮",
//                         @"笑死了这不就是大型相亲现场嘛",
//                         @"华哥笑了😄，第一次看到这种角色",
//                         @"弹幕怎么不见了",
//                         @"大幂幂每部剧都看过的举个小爪爪",
//                         @"演的太假。",
//                         @"哈哈，沈其南看到杜少乾送傅函君玫瑰花之后的表情好可爱！",
                         @"杜少亁帅"];
//    return content[arc4random()%content.count];
    return content[count % 2];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.barrage stop];
//}

- (void)dealloc {
    NSLog(@"vc dealloc");
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIView *)EVBarrageContainerView:(EVBarrageContainerView *)containerView createDisplayViewForModel:(id<EVBarrageModelProtocol>)model {
    //单个弹幕的视图，可以根据 model 信息，自定义视图；DIY【这里不需要做缓存，弹幕框架会自动缓存 相关 view】
    EVBorderLabel *label = [[EVBorderLabel alloc] init];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.strokeWidth = 1;
    label.strokeColor = [UIColor blackColor];
    
    if (model.reuseIdentifier == EVBarrageReuseIdentity_MY) {
        label.backgroundColor = [UIColor yellowColor];
    } else if (model.reuseIdentifier == EVBarrageReuseIdentity_VIP) {
        label.backgroundColor = [UIColor purpleColor];
    } else {
        label.backgroundColor = [UIColor clearColor];
    }
    return label;
}

- (void)EVBarrageContainerView:(EVBarrageContainerView *)containerView willShowDisplayView:(UIView *)displayView withModel:(id<EVBarrageModelProtocol>)model {
    //将要显示某个弹幕，在这里，需要对弹幕赋值
    EVBorderLabel *lbl = (EVBorderLabel *)displayView;
    lbl.attributedText = model.text;
}

//暂未实现
//- (void)EVBarrageContainerView:(EVBarrageContainerView *)containerView didTapDisplayView:(UIView *)displayView withModel:(id<EVBarrageModelProtocol>)model {
//    NSLog(@"tap:%@",model.text);
//}

@end
