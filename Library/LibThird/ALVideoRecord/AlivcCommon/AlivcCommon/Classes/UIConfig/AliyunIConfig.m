//
//  AliyunIConfig.m
//  AliyunVideo
//
//  Created by mengt on 2017/4/25.
//  Copyright (C) 2010-2017 Alibaba Group Holding Limited. All rights reserved.
//

#import "AliyunIConfig.h"
#import "UIColor+AlivcHelper.h"
#define kLocalizationMsg(key) NSLocalizedString(key, nil)

static AliyunIConfig *uiConfig;

@implementation AliyunIConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundColor = RGBToColor(35, 42, 66);
        _timelineBackgroundCollor = [UIColor colorWithWhite:0 alpha:0.34];
        _timelineDeleteColor = [UIColor redColor];
        _timelineTintColor = [UIColor colorWithHexString:@"0xFC4448"];
        _durationLabelTextColor = [UIColor redColor];
        _hiddenDurationLabel = NO;
        _hiddenFlashButton = NO;
        _hiddenBeautyButton = NO;
        _hiddenCameraButton = NO;
        _hiddenImportButton = NO;
        _hiddenDeleteButton = NO;
        _hiddenFinishButton = NO;
        _recordOnePart = NO;
        _filterArray = @[kLocalizationMsg(@"Filter/炽黄"),kLocalizationMsg(@"Filter/粉桃"),kLocalizationMsg(@"Filter/海蓝"),kLocalizationMsg(@"Filter/红润"),kLocalizationMsg(@"Filter/灰白"),kLocalizationMsg(@"Filter/经典"),kLocalizationMsg(@"Filter/麦茶"),kLocalizationMsg(@"Filter/浓烈"),kLocalizationMsg(@"Filter/柔柔"),kLocalizationMsg(@"Filter/闪耀"),kLocalizationMsg(@"Filter/鲜果"),kLocalizationMsg(@"Filter/雪梨"),kLocalizationMsg(@"Filter/阳光"),kLocalizationMsg(@"Filter/优雅"),kLocalizationMsg(@"Filter/朝阳"),kLocalizationMsg(@"Filter/波普"),kLocalizationMsg(@"Filter/光圈"),kLocalizationMsg(@"Filter/海盐"),kLocalizationMsg(@"Filter/黑白"),kLocalizationMsg(@"Filter/胶片"),kLocalizationMsg(@"Filter/焦黄"),kLocalizationMsg(@"Filter/蓝调"),kLocalizationMsg(@"Filter/迷糊"),kLocalizationMsg(@"Filter/思念"),kLocalizationMsg(@"Filter/素描"),kLocalizationMsg(@"Filter/鱼眼"),kLocalizationMsg(@"Filter/马赛克"),kLocalizationMsg(@"Filter/模糊")];
        _imageBundleName = @"AlivcCore";
        _recordType = AliyunIRecordActionTypeClick;
        _filterBundleName = nil;
        _showCameraButton = NO;
    }
    return self;
}

+ (AliyunIConfig *)config {
    
    return uiConfig;
}

+ (void)setConfig:(AliyunIConfig *)c {
    uiConfig = c;
}

- (NSString *)imageName:(NSString *)imageName {
    

    NSString *path = [NSString stringWithFormat:@"AlivcCore.bundle/%@",imageName];
    
    return path;
}

- (NSString *)filterPath:(NSString *)filterName {
//    NSString *filterPath = [NSString stringWithFormat:@"AlivcCore.bundle/%@",filterName];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filterName];
//    if (_filterBundleName) {
//         path = [[[NSBundle mainBundle]bundlePath] stringByAppendingPathComponent:filterName];
//    }
    return path;
}

@end
