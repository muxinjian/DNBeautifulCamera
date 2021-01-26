//
//  DNFileHelper.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNFileHelper : NSObject

/**
 tmp 文件夹
 */
+ (NSString *)temporaryDirectory;

/**
 通过文件名返回 tmp 文件夹中的文件路径
 */
+ (NSString *)filePathInTmpWithName:(NSString *)name;

/**
 通过一个后缀，返回 tmp 文件夹中的一个随机路径
 */
+ (NSString *)randomFilePathInTmpWithSuffix:(NSString *)suffix;

@end
