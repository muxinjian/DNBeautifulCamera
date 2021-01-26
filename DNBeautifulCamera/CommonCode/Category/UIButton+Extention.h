//
//  UIButton+Extention.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extention)

/// 通过图片名称来设置图片，会自动设置黑暗模式和正常模式的图片
- (void)setEnableDarkWithImageName:(NSString *)name;

/// 设置黑暗模式和正常模式的图片
- (void)setDarkImage:(UIImage *)darkImage normalImage:(UIImage *)normalImage;

/// 设置是否黑暗模式
- (void)setIsDarkMode:(BOOL)isDarkMode;

@end
