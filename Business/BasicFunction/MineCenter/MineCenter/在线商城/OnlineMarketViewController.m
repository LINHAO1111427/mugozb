//
//  OnlineMarketViewController.m
//  MineCenter
//
//  Created by klc_sl on 2020/8/24.
//

#import "OnlineMarketViewController.h"
 
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjView/KLCNetworkShowView.h>

@interface OnlineMarketViewController ()<JXCategoryViewDelegate>

@property (nonatomic, weak) JXCategoryTitleView *titleView;

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *itemArr;

@end

@implementation OnlineMarketViewController

- (void)dealloc
{
    _itemArr = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;

    self.view.backgroundColor = [UIColor whiteColor];

    [self createUI];
}

- (void)createUI{
    
    _titles = @[kLocalizationMsg(@"购买装扮"),kLocalizationMsg(@"使用装扮")];
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, 250, kNavBarHeight-kStatusBarHeight-10)];
    titleView.delegate = self;
    titleView.titles = _titles;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:18];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:18];
    titleView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    titleView.titleSelectedColor = [UIColor blackColor];
    _titleView = titleView;
    self.navigationItem.titleView = titleView;
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight)];
    [self.view addSubview:scrollV];
    scrollV.pagingEnabled = YES;
    //关联到categoryView
    titleView.contentScrollView = scrollV;
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    NSArray *requestArr = @[_makertUrl, _myPackUrl];
    scrollV.contentSize = CGSizeMake(scrollV.width * requestArr.count, scrollV.height);
    for (int i = 0; i<requestArr.count; i++) {
        KLCNetworkShowView *webV = [[KLCNetworkShowView alloc] initWithFrame:CGRectMake(i*scrollV.width, 0, scrollV.width, scrollV.height)];
        webV.showProgressLine = YES;
        [scrollV addSubview:webV];
        [webV loadRequestUrl:requestArr[i]];
        kWeakSelf(webV);
        [muArr addObject:weakwebV];
    }
    _itemArr = muArr;
}




#pragma mark - delegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    if (_itemArr.count > index) {
        KLCNetworkShowView *webV = _itemArr[index];
        [webV reloadData];
    }
}


- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return _titles.count;
}




@end
