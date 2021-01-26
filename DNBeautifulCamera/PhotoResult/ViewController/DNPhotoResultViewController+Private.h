
//
//  DNPhotoResultViewController+Private.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/23.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <GPUImage.h>

#import "DNCameraManager.h"
#import "DNPhotoResultViewController.h"

@interface DNPhotoResultViewController ()

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *backButton;

#pragma mark - Action

- (void)confirmAction:(id)sender;

- (void)backAction:(id)sender;

#pragma mark - UI

- (void)setupUI;

/// 刷新黑暗模式或正常模式
- (void)updateDarkOrNormalMode;

@end
