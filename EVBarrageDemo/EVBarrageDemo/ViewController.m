//
//  ViewController.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "ViewController.h"
#import "EVBarrage.h"
#import "EVBarrage/EVDataQueue/EVDataQueue.h"

@interface ViewController ()
{
    NSOperationQueue *_queue;
    EVDataQueue *_dataQueue;
}
@property (nonatomic, strong) EVBarrage *barrage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"bg"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgView];
    
    self.barrage = [[EVBarrage alloc] init];
    [imgView addSubview:self.barrage.displayView];

    [self.barrage start];

    [self addBarrage];
    
//    _queue = [[NSOperationQueue alloc] init];
//    _queue.maxConcurrentOperationCount = 2;
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
//
//    [_queue addOperation:op];
//    [op start];
    
//    _dataQueue = [[EVDataQueue alloc] initWithMaxCapacity:1000000];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (true)
//        {
////            for (int i = 0; i < arc4random()%100; i++) {
////                [_dataQueue enqueue:@10];
////                NSLog(@"en");
////            }
////            for (int i = 0; i < arc4random()%100; i++) {
////                [_dataQueue dequeue];
////                NSLog(@"dequeue");
////            }
//
//            [_dataQueue enqueue:@10];
//            NSLog(@"en");
//        }
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(0.5);
//        while (true)
//        {
//            [_dataQueue dequeue];
//            NSLog(@"dequeue");
//        }
//
//    });
    
//    CFTimeInterval start = CACurrentMediaTime();
//
//    int max = 100000;
//    for (int i = 0; i < max; i++) {
//        [_dataQueue enqueue:@(i)];
//    }
//    for (int i = 0; i < max; i++) {
//        NSNumber *obj = [_dataQueue dequeue];
//        NSLog(@"%@",obj);
//    }
//
//    CFTimeInterval end = CACurrentMediaTime();
//
//    NSLog(@"time：%f",end - start);
    
}

- (void)test {
    NSLog(@"test");
}

- (void)addBarrage {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5000; i++) {
            EVBarrageModel *model = [EVBarrageModel new];
            model.reuseIdentifier = @"other";
            NSString *str = [self randomCreatChinese:arc4random()%15];
            model.text = [[NSAttributedString alloc] initWithString:str];
            model.priority = EVBarragePriorityLow;

            [self.barrage addBarrage:model];
        }
    });

//    EVBarrageModel *model = [EVBarrageModel new];
//    model.reuseIdentifier = @"other";
//    NSString *str = @"1/hello world.";
//    model.text = [[NSAttributedString alloc] initWithString:str];
//    model.priority = EVBarragePriorityLow;
//
//
//    EVBarrageModel *model2 = [EVBarrageModel new];
//    model2.reuseIdentifier = @"other";
//    NSString *str2 = @"2/hello world.2/hello world.";
//    model2.text = [[NSAttributedString alloc] initWithString:str2];
//    model2.priority = EVBarragePriorityLow;
//
//    [self.barrage addBarrage:model2];
//    [self.barrage addBarrage:model];

    
//    [self performSelector:@selector(addBarrage) withObject:nil afterDelay:2];
}

- (NSMutableString*)randomCreatChinese:(NSInteger)count{
    
    NSMutableString*randomChineseString =@"".mutableCopy;
    
    for(int i = 0; i < count; i++){
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        //随机生成汉字高位
        
        NSInteger randomH =0xA1 + arc4random()%(0xFE - 0xA1 + 1);
        
        //随机生成汉子低位
        
        NSInteger randomL =0xB0+arc4random()%(0xF7-0xB0+1);
        
        //组合生成随机汉字
        
        NSInteger number = (randomH<<8)+randomL;
        
        NSData*data = [NSData dataWithBytes:&number length:2];
        
        NSString*string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        
        [randomChineseString appendString:string];
        
    }
    
    return randomChineseString;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addBarrage];
}

- (void)dealloc {
    NSLog(@"vc dealloc");
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
