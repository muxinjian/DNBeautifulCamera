//
//  DNFilterHelper.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <GPUImage.h>
#import <Foundation/Foundation.h>

@interface DNFilterHelper : NSObject

/**
 给图片上滤镜效果

 @param filter 滤镜
 @param originImage 原图
 @return 效果图
 */
+ (UIImage *)imageWithFilter:(GPUImageFilter *)filter
                 originImage:(UIImage *)originImage;

@end
