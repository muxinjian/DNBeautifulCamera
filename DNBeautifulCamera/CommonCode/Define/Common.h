//
//  Common.h
//  DNBeautifulCamera
//
//  Created by Dean on 2019/6/18.
//  Copyright © 2019年 Dean. All rights reserved.
//

#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

//R:255 G:134 B:82
#define ThemeColor RGBA(255, 134, 82, 1)
#define ThemeColorA(a) RGBA(255, 134, 82, a)

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height
#define SCREEN_SCALE UIScreen.mainScreen.scale
