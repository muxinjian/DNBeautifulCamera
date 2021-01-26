//
//  DNFilterBarView.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNFilterBarView.h"
#import "DNFilterCategoryView.h"

#import "DNFilterMaterialView.h"

static CGFloat const kFilterMaterialViewHeight = 100.0f;

@interface DNFilterBarView () <DNFilterMaterialViewDelegate, DNFilterCategoryViewDelegate>

@property (nonatomic, strong) DNFilterMaterialView *filterMaterialView;
@property (nonatomic, strong) DNFilterCategoryView *filterCategoryView;
@property (nonatomic, strong) UISwitch *beautifySwitch;
@property (nonatomic, strong) UISlider *beautifySlider;

@end

@implementation DNFilterBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Private

- (void)commonInit {
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    [self setupFilterCategoryView];
    [self setupFilterMaterialView];
    [self setupBeautifySwitch];
    [self setupBeautifySlider];
}

- (void)setupFilterCategoryView {
    self.filterCategoryView = [[DNFilterCategoryView alloc] init];
    self.filterCategoryView.delegate = self;
    self.filterCategoryView.itemNormalColor = [UIColor whiteColor];
    self.filterCategoryView.itemSelectColor = ThemeColor;
    self.filterCategoryView.itemList = @[@"内置", @"自定义"];
    self.filterCategoryView.itemFont = [UIFont systemFontOfSize:14];
    self.filterCategoryView.itemWidth = 65;
    self.filterCategoryView.bottomLineWidth = 30;
    [self addSubview:self.filterCategoryView];
    [self.filterCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(35);
    }];
}

- (void)setupFilterMaterialView {
    self.filterMaterialView = [[DNFilterMaterialView alloc] init];
    self.filterMaterialView.delegate = self;
    [self addSubview:self.filterMaterialView];
    [self.filterMaterialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(50);
        make.height.mas_equalTo(kFilterMaterialViewHeight);
    }];
}

- (void)setupBeautifySwitch {
    self.beautifySwitch = [[UISwitch alloc] init];
    self.beautifySwitch.onTintColor = ThemeColor;
    self.beautifySwitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [self.beautifySwitch addTarget:self
                            action:@selector(beautifySwitchValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.beautifySwitch];
    [self.beautifySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self.filterMaterialView.mas_bottom).offset(8);
    }];
    
    UILabel *switchLabel = [[UILabel alloc] init];
    switchLabel.textColor = [UIColor whiteColor];
    switchLabel.font = [UIFont systemFontOfSize:12];
    switchLabel.text = @"美颜";
    [self addSubview:switchLabel];
    [switchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beautifySwitch.mas_right).offset(3);
        make.centerY.equalTo(self.beautifySwitch);
    }];
}

- (void)setupBeautifySlider {
    self.beautifySlider = [[UISlider alloc] init];
    self.beautifySlider.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.beautifySlider.minimumTrackTintColor = [UIColor whiteColor];
    self.beautifySlider.maximumTrackTintColor = RGBA(255, 255, 255, 0.6);
    self.beautifySlider.value = 0.5;
    self.beautifySlider.alpha = 0;
    [self.beautifySlider addTarget:self
                            action:@selector(beautifySliderValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.beautifySlider];
    [self.beautifySlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beautifySwitch.mas_right).offset(30);
        make.centerY.equalTo(self.beautifySwitch);
        make.right.equalTo(self).offset(-10);
    }];
}

#pragma mark - Public

- (NSInteger)currentCategoryIndex {
    return self.filterCategoryView.currentIndex;
}

#pragma mark - Action

- (void)beautifySwitchValueChanged:(id)sender {
    [self.beautifySlider setHidden:!self.beautifySwitch.isOn animated:YES completion:NULL];

    if ([self.delegate respondsToSelector:@selector(filterBarView:beautifySwitchIsOn:)]) {
        [self.delegate filterBarView:self beautifySwitchIsOn:self.beautifySwitch.isOn];
    }
}

- (void)beautifySliderValueChanged:(id)sender {
    if ([self.delegate respondsToSelector:@selector(filterBarView:beautifySliderChangeToValue:)]) {
        [self.delegate filterBarView:self beautifySliderChangeToValue:self.beautifySlider.value];
    }
}

#pragma mark - Custom Accessor

- (void)setDefaultFilterMaterials:(NSArray<DNFilterMaterialModel *> *)defaultFilterMaterials {
    _defaultFilterMaterials = [defaultFilterMaterials copy];
    
    if (self.filterCategoryView.currentIndex == 0) {
        self.filterMaterialView.itemList = defaultFilterMaterials;
    }
}

- (void)setDefineFilterMaterials:(NSArray<DNFilterMaterialModel *> *)defineFilterMaterials {
    _defineFilterMaterials = [defineFilterMaterials copy];
    
    if (self.filterCategoryView.currentIndex == 1) {
        self.filterMaterialView.itemList = defineFilterMaterials;
    }
}

#pragma mark - DNFilterMaterialViewDelegate

- (void)filterMaterialView:(DNFilterMaterialView *)filterMaterialView didScrollToIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(filterBarView:materialDidScrollToIndex:)]) {
        [self.delegate filterBarView:self materialDidScrollToIndex:index];
    }
}

#pragma mark - DNFilterCategoryViewDelegate

- (void)filterCategoryView:(DNFilterCategoryView *)filterCategoryView didScrollToIndex:(NSUInteger)index {
    NSInteger currentIndex = filterCategoryView.currentIndex;
    if (currentIndex == 0) {
        self.filterMaterialView.itemList = self.defaultFilterMaterials;
    } else if (currentIndex == 1) {
        self.filterMaterialView.itemList = self.defineFilterMaterials;
    }
    
    if ([self.delegate respondsToSelector:@selector(filterBarView:categoryDidScrollToIndex:)]) {
        [self.delegate filterBarView:self categoryDidScrollToIndex:index];
    }
}

@end






