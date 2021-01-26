//
//  DNFilterMaterialView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNFilterMaterialModel.h"

@class DNFilterMaterialView;

@protocol DNFilterMaterialViewDelegate <NSObject>

- (void)filterMaterialView:(DNFilterMaterialView *)filterMaterialView didScrollToIndex:(NSUInteger)index;

@end

@interface DNFilterMaterialView : UIView

@property (nonatomic, copy) NSArray<DNFilterMaterialModel *> *itemList;
@property (nonatomic, weak) id <DNFilterMaterialViewDelegate> delegate;

@end
