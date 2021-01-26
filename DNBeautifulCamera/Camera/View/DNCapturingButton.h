//
//  DNCapturingButton.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/24.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮状态

 - DNCapturingButtonStateNormal: 默认
 - DNCapturingButtonStateRecording: 录制中
 */
typedef NS_ENUM(NSUInteger, DNCapturingButtonState) {
    DNCapturingButtonStateNormal,
    DNCapturingButtonStateRecording,
};

@class DNCapturingButton;

@protocol DNCapturingButtonDelegate <NSObject>

/**
 拍照按钮被点击
 */
- (void)capturingButtonDidClicked:(DNCapturingButton *)button;

@end

@interface DNCapturingButton : UIButton

@property (nonatomic, assign) DNCapturingButtonState capturingState;
@property (nonatomic, weak) id <DNCapturingButtonDelegate> delegate;

@end
