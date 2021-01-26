//
//  DNCameraViewController+Notification.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/19.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNCameraViewController+Private.h"

#import "DNCameraViewController+Notification.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DNCameraViewController (Notification)

- (void)addObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notification

- (void)didEnterBackground:(NSNotification *)notification {
    [self stopRecordVideo];
}

- (void)willResignActive:(NSNotification *)notification {
    [self stopRecordVideo];
}

@end

#pragma clang diagnostic pop
