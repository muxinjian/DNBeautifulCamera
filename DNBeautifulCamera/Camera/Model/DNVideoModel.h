//
//  DNVideoModel.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DNVideoModel : NSObject

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) AVURLAsset *asset;

@end
