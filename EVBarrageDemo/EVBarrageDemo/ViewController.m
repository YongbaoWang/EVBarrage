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
    [self.view addSubview:imgView];
    
//    self.barrage = [[EVBarrage alloc] init];
//    [imgView addSubview:self.barrage.displayView];
//
//    [self.barrage start];
//
//    [self addBarrage];
    
//    _queue = [[NSOperationQueue alloc] init];
//    _queue.maxConcurrentOperationCount = 2;
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
//
//    [_queue addOperation:op];
//    [op start];
    
    _dataQueue = [[EVDataQueue alloc] initWithMaxCapacity:10000];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true)
        {
//            for (int i = 0; i < arc4random()%100; i++) {
//                [_dataQueue enqueue:@10];
//                NSLog(@"en");
//            }
//            for (int i = 0; i < arc4random()%100; i++) {
//                [_dataQueue dequeue];
//                NSLog(@"dequeue");
//            }
            
            [_dataQueue enqueue:@10];
            NSLog(@"en");
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(0.5);
        while (true)
        {
            [_dataQueue dequeue];
            NSLog(@"dequeue");
        }

    });
    
}

- (void)test {
    NSLog(@"test");
}

- (void)addBarrage {
    EVBarrageModel *model = [EVBarrageModel new];
    model.reuseIdentifier = @"other";
    model.text = [[NSAttributedString alloc] initWithString:@"after loading the view."];
    model.priority = EVBarragePriorityLow;
    
    [self.barrage addBarrage:model];
    
    [self performSelector:@selector(addBarrage) withObject:nil afterDelay:0.5];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)dealloc {
    NSLog(@"vc dealloc");
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
