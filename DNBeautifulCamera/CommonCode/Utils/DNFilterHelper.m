//
//  DNFilterHelper.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNFilterHelper.h"

@implementation DNFilterHelper

+ (UIImage *)imageWithFilter:(GPUImageFilter *)filter
                 originImage:(UIImage *)originImage {
    [filter forceProcessingAtSize:originImage.size];
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:originImage];
    [picture addTarget:filter];
    
    [picture processImage];
    [filter useNextFrameForImageCapture];
    
    return [filter imageFromCurrentFramebuffer];
}


@end
