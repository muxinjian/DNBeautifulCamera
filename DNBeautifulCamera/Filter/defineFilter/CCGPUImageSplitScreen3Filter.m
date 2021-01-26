//
//  CCGPUImageSplitScreen3Filter.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/20.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "CCGPUImageSplitScreen3Filter.h"
NSString * const kCCGPUImageSplitScreen3FilterShaderString = SHADER_STRING
(
 precision highp float;
 
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 uniform float time;
 
 void main() {
     vec2 uv = textureCoordinate.xy;
     if (uv.y < 1.0/3.0) {
         uv.y = uv.y + 1.0/3.0;
     } else if (uv.y > 2.0/3.0){
         uv.y = uv.y - 1.0/3.0;
     }
     gl_FragColor = texture2D(inputImageTexture, uv);
 }
 
 );

@implementation CCGPUImageSplitScreen3Filter
- (instancetype)init {
    self = [super initWithFragmentShaderFromString:kCCGPUImageSplitScreen3FilterShaderString];
    return self;
}
@end
