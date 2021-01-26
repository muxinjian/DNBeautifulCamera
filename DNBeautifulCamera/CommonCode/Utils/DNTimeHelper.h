//
//  DNTimeHelper.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNTimeHelper : NSObject

/// 将时间戳转化为 12:59:59 格式
+ (NSString *)timeStringWithTimestamp:(NSInteger)timestamp;

@end
