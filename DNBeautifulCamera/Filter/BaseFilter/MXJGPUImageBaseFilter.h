//
//  MXJGPUImageBaseFilter.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "GPUImageFilter.h"

@interface MXJGPUImageBaseFilter : GPUImageFilter

@property (nonatomic, assign) GLint timeUniform;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) CGFloat beginTime;  // 滤镜开始应用的时间

@end
