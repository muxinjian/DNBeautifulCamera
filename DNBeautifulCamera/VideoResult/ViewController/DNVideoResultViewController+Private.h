//
//  DNVideoResultViewController+Private.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/22.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <GPUImage.h>

#import "DNAssetHelper.h"
#import "DNFileHelper.h"
#import "DNCameraManager.h"

#import "DNVideoResultViewController.h"

@interface DNVideoResultViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) CALayer *lastPlayerLayer; // 为了避免两段切换的时候出现短暂白屏

@property (nonatomic, strong) UIView *playerContainerView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, assign) NSInteger currentVideoIndex;

#pragma mark - Action

- (void)confirmAction:(id)sender;

- (void)backAction:(id)sender;

#pragma mark - UI

- (void)setupUI;

/// 刷新黑暗模式或正常模式
- (void)updateDarkOrNormalMode;

@end
