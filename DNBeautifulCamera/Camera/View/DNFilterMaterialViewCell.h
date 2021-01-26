//
//  DNFilterMaterialViewCell.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNFilterMaterialModel.h"

@interface DNFilterMaterialViewCell : UICollectionViewCell

@property (nonatomic, strong) DNFilterMaterialModel *filterMaterialModel;
@property (nonatomic, assign) BOOL isSelect;  

@end
