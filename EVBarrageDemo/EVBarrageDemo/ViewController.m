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
}
@property (nonatomic, strong) UIView<EVBarrageDisplayViewProtocol> *displayView;
@property (nonatomic, strong) id<EVBarrageDataCenterProtocol> dataCenter;

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
    
    NSObject *obj = [NSObject new];
    void *p1 = (__bridge_retained void *)obj;
    pointerArray = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
    [pointerArray addPointer:p1];
    
    
//    [self.displayView start];
    
    CFTimeInterval start = CACurrentMediaTime();
    int max = 10000000;
    EVDataQueue<NSNumber *> *queue = [[EVDataQueue alloc] initWithMaxCapacity:max];
    for (int i = 0; i < max; i++) {
        [queue push:@(i)];
    }
    
    NSNumber *a = queue.pop;
    while (a != nil) {
//        NSLog(@"%@",a);
        a = queue.pop;
    }
    
    CFTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"%f",end - start);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    void *p = [pointerArray pointerAtIndex:0];
    id obj = (__bridge_transfer NSObject *)p;
    [self.displayView performSelector:NSSelectorFromString(@"test")];
}

- (BOOL)shouldAutorotate {
    return YES;
}


@end
