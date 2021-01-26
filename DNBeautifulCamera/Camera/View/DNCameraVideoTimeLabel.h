//
//  DNCameraVideoTimeLabel.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/24.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNCameraVideoTimeLabel : UIView

@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) BOOL isDarkMode;

// 重置时间
- (void)resetTime;

@end

