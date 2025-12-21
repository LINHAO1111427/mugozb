//
//  MineLikeInfoListVC.m
//  Fans
//
//  Created by ssssssss on 2020/1/8.
//

#import "MineLikeInfoListVC.h"
#import <LibProjBase/LibProjBase.h>
#import "MineLikeShortVideoVC.h"
#import <LibProjView/DynamicClassfiyListVC.h>

@interface MineLikeInfoListVC ()<JXCategoryViewDelegate, JXCategoryTitleViewDataSource, JXCategoryListContainerViewDelegate>

@property (nonatomic, copy) NSArray *typeArr;

@end

@implementation MineLikeInfoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"我赞过的");
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCategoryView];
    
}

- (NSArray *)typeArr{
    if (!_typeArr) {
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        if ([ProjConfig getAppType] != 4) {
            [muArr addObject:@{@"type":@"1",@"title":kLocalizationMsg(@"动态")}];
        }
        if ([ProjConfig isContainShortVideo]) {
            [muArr addObject:@{@"type":@"2",@"title":kLocalizationMsg(@"短视频")}];
        }
        _typeArr = [NSArray arrayWithArray:muArr];
    }
    return _typeArr;
}
 
- (void)addCategoryView{

    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSDictionary *subDic in self.typeArr) {
        [titles addObject:subDic[@"title"]];
    }
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titles.count>1?55:0.1)];
    titleView.delegate = self;
    titleView.titles = titles;
    titleView.averageCellSpacingEnabled = YES;
    titleView.titleLabelZoomScale = 1.2;
    titleView.separatorLineShowEnabled = YES;
    titleView.titleFont = [UIFont systemFontOfSize:18];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:18];
    titleView.titleColor = kRGB_COLOR(@"#333333");
    titleView.titleSelectedColor = [ProjConfig normalColors];
    [titleView setDefaultSelectedIndex:0];
    [self.view addSubview:titleView];
 
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.contentScrollView.scrollEnabled = NO;
    listContainerView.contentScrollView.backgroundColor = [UIColor whiteColor];
    listContainerView.frame = CGRectMake(0, titleView.maxY, kScreenWidth, kScreenHeight-titleView.height-kNavBarHeight);
    [self.view addSubview:listContainerView];
    titleView.listContainer = listContainerView;
    titleView.listContainer.contentScrollView.scrollEnabled  = YES;

}



#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    //    if (_shouldHandleScreenEdgeGesture) {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    //    }
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSDictionary *subDic = self.typeArr[index];
    if ([subDic[@"type"] intValue] == 1) {// 动态
        DynamicClassfiyListVC *dynamicListVc = [[DynamicClassfiyListVC alloc] init];
        dynamicListVc.type = 3;
        dynamicListVc.userId = 0;
        return dynamicListVc;
    }else{
        MineLikeShortVideoVC *svListVC = [[MineLikeShortVideoVC alloc] init];
        return svListVC;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}
@end
