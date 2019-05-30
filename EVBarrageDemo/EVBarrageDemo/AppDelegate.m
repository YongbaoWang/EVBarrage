//
//  AppDelegate.m
//  EVBarrageDemo
//
//  Created by Ever on 2019/5/23.
//  Copyright © 2019 Ever. All rights reserved.
//

#import "AppDelegate.h"

struct Chain {
    struct Chain *next;
};

@interface AppDelegate ()
{
    struct Chain *head;
    struct Chain *rear;
    
    dispatch_queue_t _serialQueue;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    _serialQueue = dispatch_queue_create("com.hi.test", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (YES) {
//            [self add];
//            NSLog(@"add");
//        }
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (YES) {
//            [self remove];
//            NSLog(@"remove");
//        }
//    });
    
    return YES;
}

- (void)add
{
    dispatch_async(_serialQueue, ^{
        struct Chain *p = calloc(1, sizeof(struct Chain));
        p -> next = NULL;
        
        if (self->head == NULL) {
            self->head = p;
        }
        
        if (self->rear == NULL) {
            self->rear = p;
        }
        else {
            self->rear -> next = p;
            self->rear = p;
        }
    });
}

- (void)remove
{
    dispatch_async(_serialQueue, ^{
        if (self->head != NULL) {
            void *next = self->head -> next;
            free(self->head);
            self->head = next;
        } else {
            self->head = NULL;
            self->rear = NULL;
        }
    });
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
