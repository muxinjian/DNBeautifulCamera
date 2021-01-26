//
//  DNCameraViewController+RecordVideo.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/20.
//  Copyright © 2019年 Dean. All rights reserved.
//
#import "DNCameraViewController+Private.h"
#import "DNCameraViewController+RecordVideo.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DNCameraViewController (RecordVideo)

#pragma mark - Public

- (void)startRecordVideo {
    if (self.isRecordingVideo) {
        return;
    }
    self.capturingButton.capturingState = DNCapturingButtonStateRecording;
    self.isRecordingVideo = YES;
    
    [[DNCameraManager shareManager] recordVideo];
    [self startVideoTimer];
    
    [self refreshUIWhenRecordVideo];
}

- (void)stopRecordVideo {
    if (!self.isRecordingVideo) {
        return;
    }
    self.capturingButton.capturingState = DNCapturingButtonStateNormal;
    @weakify(self);
    [[DNCameraManager shareManager] stopRecordVideoWithCompletion:^(NSString *videoPath) {
        @strongify(self);
        
        self.isRecordingVideo = NO;
        
        AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
        DNVideoModel *videoModel = [[DNVideoModel alloc] init];
        videoModel.filePath = videoPath;
        videoModel.asset = asset;
        [self.videos addObject:videoModel];
        
        [self endVideoTimer];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshUIWhenRecordVideo];
        });
    }];
}

- (void)startVideoTimer {
    self.videoTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(videoTimerAction) userInfo:nil repeats:YES];
    [self.videoTimer fire];
}

- (void)endVideoTimer {
    [self.videoTimer invalidate];
    self.videoTimer = nil;
}

#pragma mark - Action

- (void)videoTimerAction {
    CMTime savedTime = kCMTimeZero;
    for (DNVideoModel *model in self.videos) {
        savedTime = CMTimeAdd(savedTime, model.asset.duration);
    }
    NSInteger timestamp = round(CMTimeGetSeconds(savedTime) + [DNCameraManager shareManager].currentDuration);
    self.videoTimeLabel.timestamp = timestamp;
}

@end

#pragma clang diagnostic pop
