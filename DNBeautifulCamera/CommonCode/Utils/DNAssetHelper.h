//
//  DNAssetHelper.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNAssetHelper : NSObject

/// 获取视频的第一帧
+ (UIImage *)videoPreviewImageWithURL:(NSURL *)url;

/// 合并视频
+ (void)mergeVideos:(NSArray *)videoPaths toExportPath:(NSString *)exportPath completion:(void (^)(void))completion;

@end
