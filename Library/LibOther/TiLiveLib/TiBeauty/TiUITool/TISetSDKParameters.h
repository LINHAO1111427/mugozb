//
//  TISetSDKParameters.h
//  XTSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIConfig.h"
#import <TiSDK/TiSDKInterface.h>

@interface TISetSDKParameters : NSObject

#pragma mark -- UI保存参数时使用到的键值枚举
typedef NS_ENUM(NSInteger, TiUIDataCategoryKey) {
    
    TI_UIDCK_SKIN_WHITENING_SLIDER = 100, // 美白拉条
    TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER = 101, // 磨皮拉条
    TI_UIDCK_SKIN_BRIGHTNESS_SLIDER = 102, // 亮度拉条
    TI_UIDCK_SKIN_TENDERNESS_SLIDER = 103, // 粉嫩拉条
    TI_UIDCK_SKIN_SKINBRIGGT_SLIDER = 104, // 鲜明拉条
     TI_UIDCK_SKIN_SATURATION_SLIDER = 105, // 饱和拉条 ->暂未
    
    TI_UIDCK_EYE_MAGNIFYING_SLIDER = 200, // 大眼拉条
    TI_UIDCK_FACE_NARROWING_SLIDER = 201, // 瘦脸拉条
    TI_UIDCK_CHIN_SLIMMING_SLIDER = 202, // 窄脸拉条
    TI_UIDCK_JAW_TRANSFORMING_SLIDER = 203, // 下巴拉条
    TI_UIDCK_FOREHEAD_TRANSFORMING_SLIDER = 204, // 额头拉条
    TI_UIDCK_MOUTH_TRANSFORMING_SLIDER = 205, // 嘴型拉条
    TI_UIDCK_NOSE_SLIMMING_SLIDER = 206, // 瘦鼻拉条
    TI_UIDCK_TEETH_WHITENING_SLIDER = 207, // 美牙拉条
    TI_UIDCK_EYE_SPACING_SLIDER = 208, // 眼间距拉条
    TI_UIDCK_NOSE_LONG_SLIDER = 209, // 长鼻拉条
    TI_UIDCK_EYE_CORNER_SLIDER = 210, // 眼角拉条
    
    TI_UIDCK_FILTER_SLIDER = 300,// 滤镜调节拉条
    
    TI_UIDCK_ONEKEY_SLIDER = 400, // 一键美颜
    
    TI_UIDCK_CheekRed_SLIDER = 1000, //  腮红
        TI_UIDCK_Eyelash_SLIDER = 2000, // 睫毛
        TI_UIDCK_Eyebrows_SLIDER = 3000, // 眉毛
//    TI_UIDCK_CheekRed_qingse_SLIDER = 1001, //  腮红 青涩
//    TI_UIDCK_CheekRed_riza_SLIDER = 1002, // 腮红 日杂
//    TI_UIDCK_CheekRed_tiancheng_SLIDER = 1003, // 腮红 甜橙
//    TI_UIDCK_CheekRed_youya_SLIDER = 1004, // 腮红 优雅
//    TI_UIDCK_CheekRed_weixun_SLIDER = 1005, // 腮红 微醺
//    TI_UIDCK_CheekRed_xindon_SLIDER = 1006, // 腮红 心动
//
//    TI_UIDCK_Eyelash_ziran_SLIDER = 2001, // 睫毛 自然
//    TI_UIDCK_Eyelash_rouhe_SLIDER = 2002, // 睫毛 柔和
//    TI_UIDCK_Eyelash_nongmi_SLIDER = 2003, // 睫毛 浓密
//    TI_UIDCK_Eyelash_meihuo_SLIDER = 2004, // 睫毛 魅惑
//    TI_UIDCK_Eyelash_babi_SLIDER = 2005, // 睫毛 芭比
//    TI_UIDCK_Eyelash_wumei_SLIDER = 2006, // 睫毛 妩媚
//
//    TI_UIDCK_Eyebrows_biaozhunmei_SLIDER = 3001, // 眉毛 标准
//    TI_UIDCK_Eyebrows_jianmei_SLIDER = 3002, // 眉毛 剑眉
//    TI_UIDCK_Eyebrows_liuyemei_SLIDER = 3003, // 眉毛 柳叶眉
//    TI_UIDCK_Eyebrows_pingzhimei_SLIDER = 3004, // 眉毛 平直眉
//    TI_UIDCK_Eyebrows_liuxingmei_SLIDER = 3005, // 眉毛 流星眉
//    TI_UIDCK_Eyebrows_oushimei_SLIDER = 3006, // 眉毛 欧式眉
    
    
    
};

// 保存key float值
+ (void)setFloatValue:(float)value forKey:(TiUIDataCategoryKey)key;

// 获取key float值
+ (float)getFloatValueForKey:(TiUIDataCategoryKey)key;

 // 保存选中美妆的坐标
+ (void)setBeautyMakeupIndex:(int)index forKey:(TiUIDataCategoryKey)key;
 // 获取选中美妆的坐标
+ (int)getBeautyMakeupIndexForKey:(TiUIDataCategoryKey)key;


+(void)initSDK;

+(void)setTotalEnable:(BOOL)enable toIndex:(NSInteger)index;

+(void)setBeautySlider:(float)v forKey:(TiUIDataCategoryKey)key withIndex:(NSInteger)index;
 
+(TiFilterEnum)getTiFilterEnumForIndex:(NSInteger)index;

+(TiRockEnum)setRockEnumByIndex:(NSInteger)index;

+(TiDistortionEnum)setDistortionEnumByIndex:(NSInteger)index;

@end
 
