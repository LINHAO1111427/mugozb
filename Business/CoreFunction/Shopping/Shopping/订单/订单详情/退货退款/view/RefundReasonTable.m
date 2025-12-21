//
//  RefundReasonTable.m
//  Shopping
//
//  Created by yww on 2020/11/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RefundReasonTable.h"
#import <LibProjModel/ApplyRefundReasonDTOModel.h>

@interface RefundReasonTableViewCell : UITableViewCell
@property (nonatomic, strong)ApplyRefundReasonDTOModel *model;
@property (nonatomic, strong)UIImageView *selectImageView;
@property (nonatomic, strong)UILabel *titleL;
@end

@implementation RefundReasonTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.titleL];
}
- (void)setModel:(ApplyRefundReasonDTOModel *)model{
    _model = model;
    self.titleL.text = model.reason;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(14, 10, kScreenWidth-30, 20)];
        _titleL.textColor = kRGB_COLOR(@"#666666");
        _titleL.font = [UIFont systemFontOfSize:13];
        _titleL.textAlignment = NSTextAlignmentLeft;
    }
    return _titleL;
}
- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 0, 16, 16)];
        _selectImageView.centerY = self.contentView.centerY;
    }
    return _selectImageView;
}
@end


@interface RefundReasonTable()<UITableViewDelegate,UITableViewDataSource>
 
@end

@implementation RefundReasonTable
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
 
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self selectRowAtIndexPath:self.selectIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RefundReasonTableViewCell *cell = (RefundReasonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[RefundReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"refundOrderReasonCell"];
    }
    NSInteger row = [indexPath row];
     NSInteger oldrow = [self.selectIndex row];
     if  (row == oldrow && self.selectIndex != nil){
         [cell.selectImageView setImage:[UIImage imageNamed:@"shop_refund_reason_selected"]];
     }else{
         [cell.selectImageView setImage:nil];
     }
    ApplyRefundReasonDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    cell.model = model;
    return cell;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyRefundReasonDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    _selectIndex = indexPath;
     
    if (self.resonDelegate && [self.resonDelegate respondsToSelector:@selector(refundReasonTableDidSelected:withModel:)]) {
        [self.resonDelegate refundReasonTableDidSelected:indexPath withModel:model];
    }
    
    RefundReasonTableViewCell *cell = [tableView cellForRowAtIndexPath:_selectIndex];
    [cell.selectImageView setImage:[UIImage imageNamed:@"shop_refund_reason_selected"]];
    
    RefundReasonTableViewCell *cellNow = [tableView cellForRowAtIndexPath:indexPath];
    [cellNow.selectImageView setImage:nil];
    [tableView reloadData];
    
     
}
@end
