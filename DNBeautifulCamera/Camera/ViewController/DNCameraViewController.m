//
//  DNCameraViewController.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/19.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNCameraViewController+Private.h"

#import "DNCameraViewController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation DNCameraViewController

- (void)dealloc {
    [self removeObserver];
    [self endVideoTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
    
    DNCameraManager *cameraManager = [DNCameraManager shareManager];
    [cameraManager addOutputView:self.cameraView];
    [cameraManager startCapturing];
    
     [self updateDarkOrNormalModeWithRatio:cameraManager.ratio];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[DNCameraManager shareManager] updateFlash];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[DNCameraManager shareManager] closeFlashIfNeed];
}

#pragma mark - Public

#pragma mark - Private

- (void)commonInit {
    [self setupData];
    [self setupUI];
    [self setupTap];
    [self addObserver];
}

- (void)setupTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)setupData {
    self.videos = [[NSMutableArray alloc] init];
    self.currentVideoScale = 1.0f;
}

- (void)forwardToPhotoResultWith:(UIImage *)image {
    DNPhotoResultViewController *resultVC = [[DNPhotoResultViewController alloc] init];
    resultVC.resultImage = image;
    [self.navigationController pushViewController:resultVC animated:NO];
}

- (void)forwardToVideoResult {
    DNVideoResultViewController *vc = [[DNVideoResultViewController alloc] init];
    vc.videos = self.videos;
    [self.videos removeAllObjects];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Custom Accessor

- (NSArray<DNFilterMaterialModel *> *)defaultFilterMaterials {
    if (!_defaultFilterMaterials) {
        _defaultFilterMaterials = [[DNFilterManager shareManager] defaultFilters];
    }
    return _defaultFilterMaterials;
}

- (NSArray<DNFilterMaterialModel *> *)defineFilterMaterials {
    if (!_defineFilterMaterials) {
        _defineFilterMaterials = [[DNFilterManager shareManager] defineFilters];
    }
    return _defineFilterMaterials;
}

#pragma mark - Action

- (void)filterAction:(id)sender {
    [self setFilterBarViewHidden:NO
                        animated:YES
                      completion:NULL];
    
    [self refreshUIWhenFilterBarShowOrHide];
    
    // 第一次展开的时候，添加数据
    if (!self.filterBarView.defaultFilterMaterials) {
        self.filterBarView.defaultFilterMaterials = self.defaultFilterMaterials;
    }
}

- (void)nextAction:(id)sender {
    [self forwardToVideoResult];
    [self refreshUIWhenRecordVideo];
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
    [self setFilterBarViewHidden:YES
                        animated:YES
                      completion:NULL];
    
    [self refreshUIWhenFilterBarShowOrHide];
}

- (void)cameraViewTapAction:(UITapGestureRecognizer *)tap {
    if (self.filterBarView.showing) {
        [self tapAction:nil];
        return;
    }
    
    CGPoint location = [tap locationInView:self.cameraView];
    [[DNCameraManager shareManager] setFocusPoint:location];
    [self showFocusViewAtLocation:location];
}

- (void)cameraViewPinchAction:(UIPinchGestureRecognizer *)pinch {
    DNCameraManager *manager = [DNCameraManager shareManager];
    CGFloat scale = pinch.scale * self.currentVideoScale;
    scale = [manager availableVideoScaleWithScale:scale];
    [manager setVideoScale:scale];
    
    if (pinch.state == UIGestureRecognizerStateEnded) {
        self.currentVideoScale = scale;
    }
}

#pragma mark - DNCapturingButtonDelegate

- (void)capturingButtonDidClicked:(DNCapturingButton *)button {
    if (self.modeSwitchView.type == SCCapturingModeSwitchTypeImage) {
        [self takePhoto];
    } else if (self.modeSwitchView.type == SCCapturingModeSwitchTypeVideo) {
        if (self.isRecordingVideo) {
            [self stopRecordVideo];
        } else {
            [self startRecordVideo];
        }
    }
}

#pragma mark - DNFilterBarViewDelegate

- (void)filterBarView:(DNFilterBarView *)filterBarView categoryDidScrollToIndex:(NSUInteger)index {
    if (index == 0 && !self.filterBarView.defaultFilterMaterials) {
        self.filterBarView.defaultFilterMaterials = self.defaultFilterMaterials;
    } else if (index == 1 && !self.filterBarView.defineFilterMaterials) {
        self.filterBarView.defineFilterMaterials = self.defineFilterMaterials;
    }
}

- (void)filterBarView:(DNFilterBarView *)filterBarView materialDidScrollToIndex:(NSUInteger)index {
    NSArray<DNFilterMaterialModel *> *models = [self filtersWithCategoryIndex:self.filterBarView.currentCategoryIndex];
    
    DNFilterMaterialModel *model = models[index];
    [[DNCameraManager shareManager].currentFilterHandler setEffectFilter:[[DNFilterManager shareManager] filterWithFilterID:model.filterID]];
}

- (void)filterBarView:(DNFilterBarView *)filterBarView beautifySwitchIsOn:(BOOL)isOn {
    if (isOn) {
        [self addBeautifyFilter];
    } else {
        [self removeBeautifyFilter];
    }
}

- (void)filterBarView:(DNFilterBarView *)filterBarView beautifySliderChangeToValue:(CGFloat)value {
    [DNCameraManager shareManager].currentFilterHandler.beautifyFilterDegree = value;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.filterBarView]) {
        return NO;
    }
    return YES;
}

#pragma mark - DNCameraTopViewDelegate

- (void)cameraTopViewDidClickRotateButton:(DNCameraTopView *)cameraTopView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[DNCameraManager shareManager] rotateCamera];
        self.currentVideoScale = 1.0f;  // 切换摄像头，重置缩放比例
    });
}

- (void)cameraTopViewDidClickFlashButton:(DNCameraTopView *)cameraTopView {
    SCCameraFlashMode mode = [DNCameraManager shareManager].flashMode;
    mode = (mode + 1) % 4;
    [DNCameraManager shareManager].flashMode = mode;
    [self updateFlashButtonWithFlashMode:mode];
}

- (void)cameraTopViewDidClickRatioButton:(DNCameraTopView *)cameraTopView {
    if (self.isChangingRatio) {
        return;
    }
    self.isChangingRatio = YES;
    
    DNCameraManager *manager =[DNCameraManager shareManager];
    SCCameraRatio ratio = manager.ratio;
    NSInteger ratioCount = [UIDevice is_iPhoneX_Series] ? 4 : 3;
    SCCameraRatio nextRatio = (ratio + 1) % ratioCount;
    
    [self changeViewToRatio:nextRatio animated:YES completion:^{
        manager.ratio = nextRatio;
    }];
    
    [self updateRatioButtonWithRatio:nextRatio];
    [self updateDarkOrNormalModeWithRatio:nextRatio];
}

- (void)cameraTopViewDidClickCloseButton:(DNCameraTopView *)cameraTopView {
    [self.videos removeAllObjects];
    [self refreshUIWhenRecordVideo];
}

#pragma mark - DNCapturingModeSwitchViewDelegate

- (void)capturingModeSwitchView:(DNCapturingModeSwitchView *)view
                didChangeToType:(SCCapturingModeSwitchType)type {
}

@end

#pragma clang diagnostic pop
