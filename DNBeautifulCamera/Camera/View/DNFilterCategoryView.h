//
//  DNFilterCategoryView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNFilterCategoryView;

@protocol DNFilterCategoryViewDelegate <NSObject>

- (void)filterCategoryView:(DNFilterCategoryView *)filterCategoryView
          didScrollToIndex:(NSUInteger)index;

@end

@interface DNFilterCategoryView : UIView

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, assign) CGFloat bottomLineWidth;
@property (nonatomic, assign) CGFloat bottomLineHeight;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@property (nonatomic, strong) NSArray <NSString *> *itemList;

@property (nonatomic, weak) id<DNFilterCategoryViewDelegate> delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end
