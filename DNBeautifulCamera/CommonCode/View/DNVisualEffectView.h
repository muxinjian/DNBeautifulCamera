//
//  DNVisualEffectView.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNVisualEffectView : UIVisualEffectView

@property (nonatomic) CGFloat grayscaleTintLevel;
@property (nonatomic) CGFloat grayscaleTintAlpha;
@property (nonatomic) BOOL lightenGrayscaleWithSourceOver;
@property (nonatomic) UIColor *colorTint;
@property (nonatomic) CGFloat colorTintAlpha;
@property (nonatomic) CGFloat colorBurnTintLevel;
@property (nonatomic) CGFloat colorBurnTintAlpha;
@property (nonatomic) CGFloat darkeningTintAlpha;
@property (nonatomic) CGFloat darkeningTintHue;
@property (nonatomic) CGFloat darkeningTintSaturation;
@property (nonatomic) BOOL darkenWithSourceOver;
@property (nonatomic) CGFloat blurRadius;
@property (nonatomic) CGFloat saturationDeltaFactor;
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat zoom;

@end

