//
//  DNCapturingModeSwitchView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/24.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SCCapturingModeSwitchType) {
    SCCapturingModeSwitchTypeImage,
    SCCapturingModeSwitchTypeVideo
};

@class DNCapturingModeSwitchView;

@protocol DNCapturingModeSwitchViewDelegate <NSObject>

- (void)capturingModeSwitchView:(DNCapturingModeSwitchView *)view
                didChangeToType:(SCCapturingModeSwitchType)type;

@end

@interface DNCapturingModeSwitchView : UIView

@property (nonatomic, assign, readonly) SCCapturingModeSwitchType type;

@property (nonatomic, assign) BOOL isDarkMode;

@property (nonatomic, weak) id <DNCapturingModeSwitchViewDelegate> delegate;

@end
