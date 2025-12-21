//
//  LogisticListTable.m
//  Shopping
//
//  Created by yww on 2020/8/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LogisticListTable.h"
#import "LogisticsDetailTableViewCell.h"
#import <LibProjModel/ApiShopLogisticsDTOModel.h>
#import <LibProjModel/LogisticsNodeDTOModel.h>

@interface LogisticListTable()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation LogisticListTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame: frame style:style];
    if (self) {
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad{
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    [self reloadData];
     
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.logisticsModel.nodeList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogisticsDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LogisticsNodeDTOModel *bean;
    if (indexPath.row < self.logisticsModel.nodeList.count) {
        bean = self.logisticsModel.nodeList[indexPath.row];
    }
    CGFloat height = [self getHeghtFromModel:bean];
    if (!cell) {
        cell = [[LogisticsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LogisticsDetailTableViewCell" height:height];
    }
    if (indexPath.row ==  self.logisticsModel.nodeList.count - 1) {
        cell.isLastOne = YES;
    }else{
        cell.isLastOne = NO;
    }
    if (indexPath.row == 0) {
        cell.isFirstOne = YES;
    }else{
        cell.isFirstOne = NO;
    }
    if (bean) {
        cell.model = bean;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogisticsNodeDTOModel *bean;
    if (indexPath.row < self.logisticsModel.nodeList.count) {
        bean = self.logisticsModel.nodeList[indexPath.row];
    }
    CGFloat height = [self getHeghtFromModel:bean];
    return height;
}
- (CGFloat)getHeghtFromModel:(LogisticsNodeDTOModel *)bean{
    CGFloat height = 50;
    CGSize size = [bean.content boundingRectWithSize:CGSizeMake(kScreenWidth-24-40-44-10, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    if (size.height+5 < 40) {
        height = 50;
    }else{
        height = size.height +20;
    }
    return height;
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}
- (void)listWillAppear{
 
}

@end
