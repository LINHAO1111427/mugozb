//
//  UserInfoPraisedTable.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoPraisedTable.h"
#import <LibProjModel/HttpApiOOOLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/CommentLableVOModel.h>
#import <LibProjModel/AnchorCommentVOModel.h>
 

@interface praisedTableCell : UITableViewCell
@property (nonatomic, strong)AnchorCommentVOModel *model;
@end
@implementation praisedTableCell
 
- (void)upDateUI{
    [self.contentView removeAllSubViews];
  
    UIImageView *commentAvaterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];
    commentAvaterImageV.contentMode = UIViewContentModeScaleAspectFit;
    commentAvaterImageV.layer.cornerRadius = 20;
    commentAvaterImageV.clipsToBounds = YES;
    [commentAvaterImageV sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[ProjConfig getAppIcon]];
    [self.contentView addSubview:commentAvaterImageV];
    
    CGSize nameSize = [self.model.username boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGFloat nameW = nameSize.width+8;
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(commentAvaterImageV.maxX+15, 15, nameW, 20)];
    nameL.textColor = kRGB_COLOR(@"#666666");
    nameL.font = [UIFont systemFontOfSize:13];
    nameL.text = self.model.username;
    nameL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nameL];
    NSUInteger num = 0;
    if (self.model.commentList.count > 3) {
        num = 3;
    }else{
        num = self.model.commentList.count;
    }
    CGFloat x = kScreenWidth-15;
    for (int j = 0; j < num; j++) {
        CommentLableVOModel *mod = self.model.commentList[j];
        CGSize size = [mod.name boundingRectWithSize:CGSizeMake(70, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
        CGFloat width =  size.width + 20;
        x -= width;
        if (x > nameL.maxX+5) {
            UILabel *tabL = [[UILabel alloc]initWithFrame:CGRectMake(x, 10, size.width+20, 30)];
            tabL.layer.cornerRadius = 15;
            tabL.clipsToBounds = YES;
            tabL.text = mod.name;
            tabL.textAlignment = NSTextAlignmentCenter;
            tabL.backgroundColor = kRGBA_COLOR(mod.fontColor, 0.2);
            tabL.textColor =  kRGB_COLOR(mod.fontColor);
            tabL.font = [UIFont systemFontOfSize:11];
            [self.contentView addSubview:tabL];
            x -= 10;
        }
    }
}
- (void)setModel:(AnchorCommentVOModel *)model{
    _model = model;
    [self upDateUI];
}
@end




@interface UserInfoPraisedTable ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong)UITableView *praisedTable;
@property (nonatomic, strong)NSMutableArray *commentArray;
@property (nonatomic, strong)UIView *emptyV;
@property (nonatomic, assign)int page;
@end

@implementation UserInfoPraisedTable

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.praisedTable];
    [self.praisedTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view);
    }];
    [self.praisedTable addSubview:self.emptyV];
    [self.praisedTable registerClass:[praisedTableCell class] forCellReuseIdentifier:@"praisedTableCellId"];
    kWeakSelf(self);
    self.praisedTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself getCommentList:NO];
    }];
}
- (void)getCommentList:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiOOOLive anchorCommentList:self.userModel.userId pageIndex:self.page pageSize:kPageSize callback:^(int code, NSString *strMsg, NSArray<AnchorCommentVOModel *> *arr) {
        [weakself.praisedTable.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.commentArray removeAllObjects];
            }
            [weakself.commentArray addObjectsFromArray:arr];
            if (arr.count == 0) {
                [self.praisedTable.mj_footer endRefreshingWithNoMoreData];
            }
            weakself.emptyV.hidden = weakself.commentArray.count;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.praisedTable reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    praisedTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[praisedTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"praisedTableCellId"];
    }
    AnchorCommentVOModel *model;
    if (indexPath.row < self.commentArray.count) {
        model = self.commentArray[indexPath.row];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark - JXPagerViewListViewDelegate
- (UIView *)listView{
    self.page = 0;
    [self getCommentList:YES];
    return self.view;
}
- (UIScrollView *)listScrollView {
    return self.praisedTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollCallback(scrollView);
}

- (void)listScrollViewWillResetContentOffset{
}
- (void)listDidAppear{
    
}
- (void)listDidDisappear{
    
}

#pragma mark - lazy
- (UITableView *)praisedTable{
    if (!_praisedTable) {
        _praisedTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _praisedTable.backgroundColor = [UIColor whiteColor];
        _praisedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _praisedTable.delegate = self;
        _praisedTable.dataSource = self;
    }
    return _praisedTable;
}
-(NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
- (UIView *)emptyV{
    if (!_emptyV) {
        UIView *emptyView = [[UIView alloc] initWithFrame:self.praisedTable.bounds];
        UILabel *nodataL = [[UILabel alloc]initWithFrame:CGRectMake(20, self.praisedTable.bounds.size.height/2.0-100, kScreenWidth-40, 20)];
        nodataL.textColor = kRGB_COLOR(@"#333333");
        nodataL.font = [UIFont systemFontOfSize:16];
        nodataL.text = kLocalizationMsg(@"暂时没有评价数据哦");
        nodataL.textAlignment = NSTextAlignmentCenter;
        [emptyView addSubview:nodataL];
        _emptyV = emptyView;
    }
    return _emptyV;
}
@end
