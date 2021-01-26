//
//  CCGPUImageReversalFilter.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/20.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "CCGPUImageReversalFilter.h"

NSString * const kCCGPUImageReversalFilterShaderString = SHADER_STRING
(
 precision highp float;
 
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 void main (void) {
     
     vec4 color = texture2D(inputImageTexture, vec2(textureCoordinate.x, 1.0 - textureCoordinate.y));
     
     gl_FragColor = color;
 }
 
 );


@implementation CCGPUImageReversalFilter

- (instancetype)init {
    self = [super initWithFragmentShaderFromString:kCCGPUImageReversalFilterShaderString];
    return self;
}

@end
