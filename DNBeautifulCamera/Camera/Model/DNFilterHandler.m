//
//  DNFilterHandler.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "LFGPUImageBeautyFilter.h"
#import "MXJGPUImageBaseFilter.h"

#import "DNFilterHandler.h"

@interface DNFilterHandler ()

@property (nonatomic, strong) NSMutableArray<GPUImageFilter *> *filters;

@property (nonatomic, strong) GPUImageCropFilter *currentCropFilter;

@property (nonatomic, weak) GPUImageFilter *currentBeautifyFilter;
@property (nonatomic, weak) GPUImageFilter *currentEffectFilter;

@property (nonatomic, strong) LFGPUImageBeautyFilter *defaultBeautifyFilter;

@property (nonatomic, strong) CADisplayLink *displayLink;  // 用来刷新时间

@end

@implementation DNFilterHandler

- (void)dealloc {
    [self endDisplayLink];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Public

- (GPUImageFilter *)firstFilter {
    return self.filters.firstObject;
}

- (GPUImageFilter *)lastFilter {
    return self.filters.lastObject;
}

- (void)setCropRect:(CGRect)rect {
    self.currentCropFilter.cropRegion = rect;
}

- (void)addFilter:(GPUImageFilter *)filter {
    NSArray *targets = self.filters.lastObject.targets;
    [self.filters.lastObject removeAllTargets];
    [self.filters.lastObject addTarget:filter];
    for (id <GPUImageInput> input in targets) {
        [filter addTarget:input];
    }
    [self.filters addObject:filter];
}

- (void)setEffectFilter:(GPUImageFilter *)filter {
    if (!filter) {
        filter = [[GPUImageFilter alloc] init];
    }
    if (!self.currentEffectFilter) {
        [self addFilter:filter];
    } else {
        NSInteger index = [self.filters indexOfObject:self.currentEffectFilter];
        GPUImageOutput *source = index == 0 ? self.source : self.filters[index - 1];
        for (id <GPUImageInput> input in self.currentEffectFilter.targets) {
            [filter addTarget:input];
        }
        [source removeTarget:self.currentEffectFilter];
        [self.currentEffectFilter removeAllTargets];
        [source addTarget:filter];
        self.filters[index] = filter;
    }
    self.currentEffectFilter = filter;
    
    // 记录应用的时间
    if ([filter isKindOfClass:[MXJGPUImageBaseFilter class]]) {
        ((MXJGPUImageBaseFilter *)filter).beginTime = self.displayLink.timestamp;
    }
}

#pragma mark - Custom Accessor

- (void)setBeautifyFilterEnable:(BOOL)beautifyFilterEnable {
    _beautifyFilterEnable = beautifyFilterEnable;
    
    [self setBeautifyFilter:beautifyFilterEnable ? (GPUImageFilter *)self.defaultBeautifyFilter : nil];
}

- (void)setBeautifyFilterDegree:(CGFloat)beautifyFilterDegree {
    if (!self.beautifyFilterEnable) {
        return;
    }
    _beautifyFilterDegree = beautifyFilterDegree;
    self.defaultBeautifyFilter.beautyLevel = beautifyFilterDegree;
}

- (LFGPUImageBeautyFilter *)defaultBeautifyFilter {
    if (!_defaultBeautifyFilter) {
        _defaultBeautifyFilter = [[LFGPUImageBeautyFilter alloc] init];
    }
    return _defaultBeautifyFilter;
}

#pragma mark - Private

- (void)commonInit {
    _beautifyFilterDegree = 0.5f;
    self.filters = [[NSMutableArray alloc] init];
    [self addCropFilter];
    [self addBeautifyFilter];
    [self setupDisplayLink];
}

- (void)addCropFilter {
    self.currentCropFilter = [[GPUImageCropFilter alloc] init];
    [self addFilter:self.currentCropFilter];
}

- (void)addBeautifyFilter {
    [self setBeautifyFilter:nil];
}

- (void)setBeautifyFilter:(GPUImageFilter *)filter {
    if (!filter) {
        filter = [[GPUImageFilter alloc] init];
    }
    if (!self.currentBeautifyFilter) {
        [self addFilter:filter];
    } else {
        NSInteger index = [self.filters indexOfObject:self.currentBeautifyFilter];
        GPUImageOutput *source = index == 0 ? self.source : self.filters[index - 1];
        for (id <GPUImageInput> input in self.currentBeautifyFilter.targets) {
            [filter addTarget:input];
        }
        [source removeTarget:self.currentBeautifyFilter];
        [self.currentBeautifyFilter removeAllTargets];
        [source addTarget:filter];
        self.filters[index] = filter;
    }
    self.currentBeautifyFilter = filter;
}


- (void)setupDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(displayAction)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)endDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark - Action

- (void)displayAction {
    if ([self.currentEffectFilter isKindOfClass:[MXJGPUImageBaseFilter class]]) {
        MXJGPUImageBaseFilter *filter = (MXJGPUImageBaseFilter *)self.currentEffectFilter;
        filter.time = self.displayLink.timestamp - filter.beginTime;
    }
}

@end








