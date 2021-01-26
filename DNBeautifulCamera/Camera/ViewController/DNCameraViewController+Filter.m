//
//  DNCameraViewController+Filter.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/19.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNCameraViewController+Private.h"

#import "DNCameraViewController+Filter.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DNCameraViewController (Filter)

#pragma mark - Public

- (void)addBeautifyFilter {
    [DNCameraManager shareManager].currentFilterHandler.beautifyFilterEnable = YES;
}

- (void)removeBeautifyFilter {
    [DNCameraManager shareManager].currentFilterHandler.beautifyFilterEnable = NO;
}

- (NSArray<DNFilterMaterialModel *> *)filtersWithCategoryIndex:(NSInteger)index {
    if (index == 0) {
        return self.defaultFilterMaterials;
    } else if (index == 1) {
        return self.defineFilterMaterials;
    }
    return nil;
}

@end

#pragma clang diagnostic pop
