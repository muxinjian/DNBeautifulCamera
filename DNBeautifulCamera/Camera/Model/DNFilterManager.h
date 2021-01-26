//
//  DNFilterManager.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <GPUImage.h>

#import <Foundation/Foundation.h>

#import "DNFilterMaterialModel.h"

@interface DNFilterManager : NSObject

/// GPUImage 自带滤镜列表
@property (nonatomic, strong, readonly) NSArray<DNFilterMaterialModel *> *defaultFilters;
/// 自定义滤镜列表
@property (nonatomic, strong, readonly) NSArray<DNFilterMaterialModel *> *defineFilters;

/**
 获取实例
 */
+ (DNFilterManager *)shareManager;

/**
 通过滤镜 ID 返回滤镜对象
 */
- (GPUImageFilter *)filterWithFilterID:(NSString *)filterID;

@end
