//
//  DNFilterMaterialView.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNFilterMaterialViewCell.h"

#import "DNFilterMaterialView.h"

static NSString * const kDNFilterMaterialViewReuseIdentifier = @"DNFilterMaterialViewReuseIdentifier";

@interface DNFilterMaterialView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) DNFilterMaterialModel *selectMaterialModel;

@end

@implementation DNFilterMaterialView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Public

- (void)scrollToIndex:(NSUInteger)index {
    if (_currentIndex == index) {
        return;
    }
    if (index >= _itemList.count) {
        return;
    }
    
    [self selectIndex:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)scrollToTop {
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark - Private

- (void)commonInit {
    [self createCollectionViewLayout];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[self bounds] collectionViewLayout:_collectionViewLayout];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[DNFilterMaterialViewCell class] forCellWithReuseIdentifier:kDNFilterMaterialViewReuseIdentifier];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self selectIndex:0];
    });
}

- (void)createCollectionViewLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置间距
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置item尺寸
    CGFloat itemW = 60;
    CGFloat itemH = 100;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    // 设置水平滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionViewLayout = flowLayout;
}

- (void)selectIndex:(NSIndexPath *)indexPath {
    DNFilterMaterialViewCell *lastSelectCell = (DNFilterMaterialViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    DNFilterMaterialViewCell *currentSelectCell = (DNFilterMaterialViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    lastSelectCell.isSelect = NO;
    currentSelectCell.isSelect = YES;
    
    self.currentIndex = indexPath.row;
    self.selectMaterialModel = self.itemList[self.currentIndex];

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(filterMaterialView:didScrollToIndex:)]) {
        [self.delegate filterMaterialView:self didScrollToIndex:indexPath.row];
    }
}

#pragma mark - Custom Accessor

- (void)setItemList:(NSArray<DNFilterMaterialModel *> *)itemList {
    _itemList = [itemList copy];
    
    [self.collectionView reloadData];
    if ([itemList containsObject:self.selectMaterialModel]) {
        NSInteger index = [itemList indexOfObject:self.selectMaterialModel];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    } else {
        [self scrollToTop];
    }
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DNFilterMaterialViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDNFilterMaterialViewReuseIdentifier forIndexPath:indexPath];
    cell.filterMaterialModel = self.itemList[indexPath.row];
    cell.isSelect = cell.filterMaterialModel == self.selectMaterialModel;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectIndex:indexPath];
}

@end
