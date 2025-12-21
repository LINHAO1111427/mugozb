//
//  AnchorAudioLinkManagerView.m
//  MPAudioLive
//
//  Created by klc_sl on 2021/8/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "AnchorAudioLinkManagerView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <JXCategoryView/JXCategoryView.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

#import "ApplyLinkAudienceListView.h"
#import "AudioOnlineListView.h"
#import "AudioLinkUserListView.h"

@interface AnchorAudioLinkManagerView ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, weak)JXCategoryTitleView *titleV;
@property (nonatomic, copy)NSArray *itemArr;

@end

@implementation AnchorAudioLinkManagerView

+ (AnchorAudioLinkManagerView *)showMangerView {
    
    AnchorAudioLinkManagerView *linkV = [[AnchorAudioLinkManagerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 395+kSafeAreaBottom)];
    [linkV createUI];
    [FunctionSheetBaseView showView:linkV cover:NO];
    return linkV;
}

- (NSArray *)itemArr{
    if (!_itemArr) {
        _itemArr = @[@{@"title":kLocalizationMsg(@"在线用户"),@"type":@"0"},
                     @{@"title":kLocalizationMsg(@"上麦申请"),@"type":@"1"},
                     @{@"title":kLocalizationMsg(@"连麦管理"),@"type":@"2"},];
    }
    return _itemArr;
}

- (void)reloadLinkUser{
    
}

- (void)createUI{
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.itemArr) {
        [titles addObject:dic[@"title"]];
    }
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.indicatorWidth = 30.0;
    
    JXCategoryTitleView *titleV = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    titleV.delegate = self;
    titleV.titles = titles;
    titleV.indicators = @[lineView];
    titleV.backgroundColor = [UIColor clearColor];
    titleV.titleFont = [UIFont systemFontOfSize:14];
    titleV.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleV.cellSpacing = 5;
    titleV.titleColor = [UIColor lightGrayColor];
    titleV.titleSelectedColor = [UIColor blackColor];
    [self addSubview:titleV];
    self.titleV = titleV;
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, titleV.maxY, self.width, self.height-titleV.height);
    [self addSubview:listContainerView];
    self.titleV.listContainer = listContainerView;

}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    NSDictionary *dict = self.itemArr[index];
    switch ([dict[@"type"] intValue]) {
        case 0:{///在线用户
            AudioOnlineListView *online = [[AudioOnlineListView alloc] init];
            return online;
        }
            break;
        case 1:{ ///上麦申请
            ApplyLinkAudienceListView *linkView = [[ApplyLinkAudienceListView alloc] init];
            return linkView;
        }
            break;
        case 2:{///连麦管理
            AudioLinkUserListView *listView = [[AudioLinkUserListView alloc] init];
            return listView;
        }
            break;
    }
    return nil;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.itemArr.count;
}


@end
