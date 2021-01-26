//
//  DNCameraViewController+TakePhoto.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/20.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNCameraViewController+Private.h"

#import "DNCameraViewController+TakePhoto.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DNCameraViewController (TakePhoto)

- (void)takePhoto {
    @weakify(self);
    [[DNCameraManager shareManager] takePhotoWtihCompletion:^(UIImage *resultImage,
                                                              NSError *error) {
        @strongify(self);
        [self forwardToPhotoResultWith:resultImage];
    }];
}

@end

#pragma clang diagnostic pop
