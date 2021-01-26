//
//  DNCameraTopView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/24.
//  Copyright © 2019年 Dean. All rights reserved.
//
#import <UIKit/UIKit.h>

@class DNCameraTopView;

@protocol DNCameraTopViewDelegate <NSObject>

- (void)cameraTopViewDidClickRotateButton:(DNCameraTopView *)cameraTopView;
- (void)cameraTopViewDidClickFlashButton:(DNCameraTopView *)cameraTopView;
- (void)cameraTopViewDidClickRatioButton:(DNCameraTopView *)cameraTopView;
- (void)cameraTopViewDidClickCloseButton:(DNCameraTopView *)cameraTopView;

@end

@interface DNCameraTopView : UIView

@property (nonatomic, strong, readonly) UIButton *rotateButton;  // 切换前后置按钮
@property (nonatomic, strong, readonly) UIButton *flashButton;  // 闪光灯按钮
@property (nonatomic, strong, readonly) UIButton *ratioButton;  // 比例按钮
@property (nonatomic, strong, readonly) UIButton *closeButton;  // 关闭按钮

@property (nonatomic, weak) id <DNCameraTopViewDelegate> delegate;

@end
