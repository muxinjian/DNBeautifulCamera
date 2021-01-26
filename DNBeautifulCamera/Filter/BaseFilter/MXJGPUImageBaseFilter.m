//
//  MXJGPUImageBaseFilter.m
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#import "MXJGPUImageBaseFilter.h"

@implementation MXJGPUImageBaseFilter

- (id)initWithVertexShaderFromString:(NSString *)vertexShaderString
            fragmentShaderFromString:(NSString *)fragmentShaderString {
    NSLog(@"%@",vertexShaderString);
    self = [super initWithVertexShaderFromString:vertexShaderString
                        fragmentShaderFromString:fragmentShaderString];
   
    self.timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0f;
    
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    
    [self setFloat:time forUniform:self.timeUniform program:filterProgram];
}

@end
