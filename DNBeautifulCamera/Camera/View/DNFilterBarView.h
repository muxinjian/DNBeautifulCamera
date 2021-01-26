//
//  DNFilterBarView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNFilterMaterialModel.h"

@class DNFilterBarView;

@protocol DNFilterBarViewDelegate <NSObject>

- (void)filterBarView:(DNFilterBarView *)filterBarView categoryDidScrollToIndex:(NSUInteger)index;
- (void)filterBarView:(DNFilterBarView *)filterBarView materialDidScrollToIndex:(NSUInteger)index;
- (void)filterBarView:(DNFilterBarView *)filterBarView beautifySwitchIsOn:(BOOL)isOn;
- (void)filterBarView:(DNFilterBarView *)filterBarView beautifySliderChangeToValue:(CGFloat)value;

@end

@interface DNFilterBarView : UIView

@property (nonatomic, assign) BOOL showing;
@property (nonatomic, weak) id <DNFilterBarViewDelegate> delegate;

// GPUImage内置滤镜
@property (nonatomic, copy) NSArray<DNFilterMaterialModel *> *defaultFilterMaterials;

// 自定义滤镜
@property (nonatomic, copy) NSArray<DNFilterMaterialModel *> *defineFilterMaterials;

- (NSInteger)currentCategoryIndex;

@end
