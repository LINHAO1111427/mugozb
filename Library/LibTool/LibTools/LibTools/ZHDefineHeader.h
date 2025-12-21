//
//  ZHDefineHeader.h
//  LibTools
//
//  Created by klc on 2020/7/31.
//  Copyright © 2020 klc. All rights reserved.
//

#ifndef ZHDefineHeader_h
#define ZHDefineHeader_h


#import "Color.h"
#import "PopCtr.h"
#import "UIColor+Extra.h"
#import "UIView+Gradient.h"
#import "Maker.h"

//img
#define ImgNamed(x)         [UIImage imageNamed:x]
#define kFont(x)            [UIFont systemFontOfSize:x]
#define kStringFormat(x,...)        [NSString stringWithFormat:x, __VA_ARGS__]

//rect
#define SIZE(width,height)          CGSizeMake(width, height)
#define POINT(x,y)                  CGPointMake(x, y)
#define RECT(x,y,width,height)      CGRectMake(x, y, width, height)

//属性
#define kStrong(class,name)         @property(nonatomic,strong)class *name;
#define kCopyStr(name)              @property(nonatomic,copy)NSString *name;
#define kAssign(type,name)          @property(nonatomic,assign)type name;
#define kBlock(name,...)            @property(nonatomic,copy)void (^name)(__VA_ARGS__);

//Hud
#define HudShowString(x)            [SVProgressHUD showInfoWithStatus:x];
#define HudShowError(x)             [SVProgressHUD showErrorWithStatus:x];
#define HudDismiss                  [SVProgressHUD dismiss];
#define HudShowSuccess(x)           [SVProgressHUD showSuccessWithStatus:x];
#define HudShowStatus(x)            [SVProgressHUD showWithStatus:x];



#endif /* ZHDefineHeader_h */
