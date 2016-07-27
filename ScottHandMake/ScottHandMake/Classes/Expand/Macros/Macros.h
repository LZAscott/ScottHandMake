//
//  Macros.h
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#ifdef DEBUG
#define ScottLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define ScottLog(s, ... )
#endif



#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight        CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])
#define kNavigationBarHeight    CGRectGetHeight(self.navigationController.navigationBar.frame)
#define kTabbarHeight           CGRectGetHeight(self.tabBarController.tabBar.frame)

#define kFitHeight(h)           (kScreenHeight/667) * (h)
#define kFitWidth(w)            (kScreenWidth/375) * (w)




#define ScottColorWithRGB(r,g,b)  [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:1]
#define ScottAppearanceBgColor ScottColorWithRGB(209.0, 68.0, 66.0)
#define ScottSegmentColor       ScottColorWithRGB(215.0, 95.0, 94.0);

#endif /* Macros_h */
