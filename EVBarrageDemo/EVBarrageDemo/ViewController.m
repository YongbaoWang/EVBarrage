//
//  ViewController.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "ViewController.h"
#import "EVBarrage/EVBarrageManager.h"
#import "EVBarrage/EVDataQueue.h"

@interface ViewController ()
{
    NSPointerArray *pointerArray;
    EVDataQueue *_queue;
}
@property (nonatomic, strong) UIView<EVBarrageDisplayViewProtocol> *displayView;
@property (nonatomic, strong) id<EVBarrageDataCenterProtocol> dataCenter;

@property (nonatomic, weak) id last;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.displayView = [EVBarrageManager createDisplayView];
    self.displayView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.displayView];

    self.dataCenter = [EVBarrageManager createDataCenter];
    self.displayView.dataSource = self.dataCenter;
    
    
    
//    [self.displayView start];
    
    CFTimeInterval start = CACurrentMediaTime();
    int max = 10000000; //10000000
    EVDataQueue<NSObject *> *queue = [[EVDataQueue alloc] initWithMaxCapacity:max];
    _queue = queue;
    
    for (int i = 0; i < max; i++) {
        NSObject *b = [NSObject new];
        [queue push:b];
    }

    NSNumber *a;
    for (int i = 0; i < max - 1; i++) {
        a = queue.pop;
    }
    
//    NSObject *b = [NSObject new];
    self.last = a;

    
    
//    NSMutableArray *a1 = [[NSMutableArray alloc] initWithCapacity:max];
//    NSPointerArray *a2 = [NSPointerArray weakObjectsPointerArray];
//    for (int i = 0; i < max; i++) {
//        NSNumber *n1 = @(i);
//        [a1 addObject:n1];
////        [a2 addPointer:(__bridge void *)@(i)];
//        [a2 insertPointer:(__bridge void *)n1 atIndex:i];
//    }
//
//    for (int i = 0; i < max; i++) {
////        id obj = a1[i];
//        id obj = (__bridge id)[a2 pointerAtIndex:i];
//    }
    
    
//    NSMutableSet *set1 = [NSMutableSet setWithCapacity:max];
//    for (int i = 0; i < max; i++) {
//        [set1 addObject:@(i)];
//    }
    
//    NSHashTable *ht1 = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
//    for (int i = 0; i < max; i++) {
//        [ht1 addObject:@(i)];
//    }
    
    
    CFTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"%f",end - start);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//        NSNumber *a = _queue.pop;
//        while (a != nil) {
//            NSLog(@"%@",a);
//            a = _queue.pop;
//        }
    [_queue freeAll];
}

- (BOOL)shouldAutorotate {
    return YES;
}


@end
