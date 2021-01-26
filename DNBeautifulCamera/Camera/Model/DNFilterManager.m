//
//  DNFilterManager.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "DNFilterManager.h"

static DNFilterManager *_filterManager;

@interface DNFilterManager ()

@property (nonatomic, strong, readwrite) NSArray<DNFilterMaterialModel *> *defaultFilters;
@property (nonatomic, strong, readwrite) NSArray<DNFilterMaterialModel *> *defineFilters;

@property (nonatomic, strong) NSDictionary *defaultFilterMaterialsInfo;
@property (nonatomic, strong) NSDictionary *defineFilterMaterialsInfo;

@property (nonatomic, strong) NSMutableDictionary *filterClassInfo;

@end

@implementation DNFilterManager

+ (DNFilterManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _filterManager = [[DNFilterManager alloc] init];
    });
    return _filterManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Public

- (GPUImageFilter *)filterWithFilterID:(NSString *)filterID {
    NSString *className = self.filterClassInfo[filterID];
    
    Class filterClass = NSClassFromString(className);
    return [[filterClass alloc] init];
}

#pragma mark - Private

- (void)commonInit {
    self.filterClassInfo = [[NSMutableDictionary alloc] init];
    [self setupDefaultFilterMaterialsInfo];
    [self setupDefineFilterMaterialsInfo];
}

- (void)setupDefaultFilterMaterialsInfo {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DefaultFilterMaterials" ofType:@"plist"];
    NSDictionary *info = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.defaultFilterMaterialsInfo = [info copy];
}

- (void)setupDefineFilterMaterialsInfo {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DefineFilterMaterials" ofType:@"plist"];
    NSDictionary *info = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.defineFilterMaterialsInfo = [info copy];
}

- (NSArray<DNFilterMaterialModel *> *)setupFiltersWithInfo:(NSDictionary *)info {
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    
    NSArray *defaultArray = info[@"Default"];
    
    for (NSDictionary *dict in defaultArray) {
        DNFilterMaterialModel *model = [[DNFilterMaterialModel alloc] init];
        model.filterID = dict[@"filter_id"];
        model.filterName = dict[@"filter_name"];
        
        [mutArr addObject:model];
        
        self.filterClassInfo[dict[@"filter_id"]] = dict[@"filter_class"];
    }
    
    return [mutArr copy];
}

#pragma mark - Custom Accessor

- (NSArray<DNFilterMaterialModel *> *)defaultFilters {
    if (!_defaultFilters) {
        _defaultFilters = [self setupFiltersWithInfo:self.defaultFilterMaterialsInfo];
    }
    return _defaultFilters;
}

- (NSArray<DNFilterMaterialModel *> *)defineFilters {
    if (!_defineFilters) {
        _defineFilters = [self setupFiltersWithInfo:self.defineFilterMaterialsInfo];
    }
    return _defineFilters;
}

@end
