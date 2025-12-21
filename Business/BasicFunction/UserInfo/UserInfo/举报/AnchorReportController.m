//
//  AnchorReportController.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "AnchorReportController.h"
#import "ReportItemCell.h"

#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibTools/LibTools.h>
#import <LibProjView/ZDropScrollView.h>
#import <LibProjBase/ProjConfig.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjModel/HttpApiUserManagerController.h>

@interface AnchorReportController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ZDropScrollViewDelegate>

@property (nonatomic,weak) UITextView *repostTextV;
@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,weak) UITableView *tableV;
@property (nonatomic,weak) ZDropScrollView *reportInfoScroll;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong)NSMutableArray *picArr;



@end

@implementation AnchorReportController

-(void)doReturn{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectIndex = 999;
    
    self.navigationItem.title = kLocalizationMsg(@"举报");
    
    [self createUI];
    [self requetData];
    
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)createUI{
    ///头部视图
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, kScreenWidth-10, 40)];
    headerLabel.text = kLocalizationMsg(@"选择举报的类型");
    headerLabel.textColor =kRGB_COLOR(@"#666666");
    headerLabel.font = [UIFont systemFontOfSize:13];
    [headV addSubview:headerLabel];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = headV;
    table.backgroundColor = [UIColor whiteColor];
    [table registerClass:[ReportItemCell class] forCellReuseIdentifier:ReportItemCellIdentifier];
    table.tableFooterView = [self footView];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    self.tableV = table;
}

///尾部视图
- (UIView *)footView{
    
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    UITextView *reportTextV = [[UITextView alloc]initWithFrame:CGRectMake(30, 10, kScreenWidth-60 ,100)];
    reportTextV.delegate = self;
    reportTextV.layer.masksToBounds = YES;
    reportTextV.layer.cornerRadius = 5.0;
    reportTextV.font = [UIFont systemFontOfSize:13];
    reportTextV.textColor = kRGB_COLOR(@"#333333");
    reportTextV.placeholder = kLocalizationMsg(@"请填写举报内容");
    reportTextV.placeholderColor = kRGBA_COLOR(@"#999999", 1.0);
    reportTextV.backgroundColor = kRGBA_COLOR(@"#F4F4F4", 1.0);
    [footV addSubview:reportTextV];
    _repostTextV = reportTextV;
    
    ///选择图片
    ZDropScrollView *reportInfoScroll = [[ZDropScrollView alloc] initWithFrame:CGRectMake(reportTextV.x-10, reportTextV.maxY + 20, reportTextV.width+20, 110)];
    reportInfoScroll.scrollEnabled = NO;
    reportInfoScroll.o_delegate = self;
    reportInfoScroll.o_maxCount = 3;
    reportInfoScroll.sDROPVIEW_MARGIN = (reportTextV.width-270)/2.0;
    reportInfoScroll.sDROPVIEW_SIZE = 90;
    reportInfoScroll.deleteImageStr = @"live_guanbi_white_mini";
    reportInfoScroll.sDROPVIEW_COUNT = 3;
    reportInfoScroll.addImageStr = @"report_select_img";
    [footV addSubview:reportInfoScroll];
    [reportInfoScroll reloadData];
    _reportInfoScroll = reportInfoScroll;
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(20, CGRectGetMaxY(reportInfoScroll.frame)+30, 148, 40);
    btn.centerX = reportTextV.centerX;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20.0;
    btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [btn setTitle:kLocalizationMsg(@"提交举报") forState:0];
    [btn addTarget:self action:@selector(repostCommit) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:btn];
    
    footV.height = btn.maxY+40;
    
    return footV;
}

- (void)requetData{
    kWeakSelf(self);
    [HttpApiUserManagerController getUserAppealTypeList:^(int code, NSString *strMsg, NSArray<UserAppealTypeVOModel *> *arr) {
        if (code == 1) {
            weakself.dataArr = arr;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (NSMutableArray *)picArr{
    if (!_picArr) {
        _picArr = [[NSMutableArray alloc] init];
    }
    return _picArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportItemCellIdentifier];
    UserAppealTypeVOModel *model =  _dataArr[indexPath.row];
    cell.leftLabel.text = model.appealTypeName;
    cell.selectItem = (indexPath.row == _selectIndex)?YES:NO;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [tableView reloadData];
    [self hideKeboard];
}

- (void)repostCommit{
    [self hideKeboard];
    if (self.selectIndex >= self.dataArr.count) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择举报理由")];
        return;
    }
    if (self.userId <= 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择被举报人")];
        return;
    }
    NSMutableString *picStr = [[NSMutableString alloc] init];
    for (NSString *picUrl in self.picArr) {
        [picStr appendFormat:@",%@",picUrl];
    }
    if (picStr.length > 0) {
        [picStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    UserAppealTypeVOModel *model = _dataArr[self.selectIndex];

    kWeakSelf(self);
    [HttpApiUserManagerController addUserAppeal:self.userId userAppealDescription:self.repostTextV.text userAppealImages:picStr userAppealTypeId:model.id_field userAppealTypeName:model.appealTypeName callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

- (void)hideKeboard{
    [_repostTextV resignFirstResponder];
}
#pragma mark -- 获取键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat buttomH = kScreenHeight-kNavBarHeight - CGRectGetMaxY([self.tableV rectForSection:0]) - 180;
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        CGRect rc = weakself.tableV.frame;
        rc.origin.y = rc.origin.y - (keyboardRect.size.height-buttomH);
        weakself.tableV.frame = rc;
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{   NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        weakself.tableV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_repostTextV resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -ZDropScrollViewDelegate-
- (void)addNewView:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    NSInteger num = scrollView.o_maxCount-scrollView.o_imageDatas.count;
    imagePickerVc.maxImagesCount = num>0?num:1;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.showSelectBtn = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///上传
        for (UIImage *image in photos) {
            [weakself uploadImage:image scrollView:scrollView];
        }
    }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)removeIndex:(NSInteger)index andView:(ZDropScrollView*)scrollView{
    [self.picArr removeObjectAtIndex:index];
    self.reportInfoScroll.o_imageDatas = self.picArr;
    [self.reportInfoScroll reloadData];
}

//上传
- (void)uploadImage:(UIImage *)image scrollView:(ZDropScrollView *)scrollView{
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:8 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            [weakself.picArr addObject:imageUrl];
            weakself.reportInfoScroll.o_imageDatas = weakself.picArr;
            [weakself.reportInfoScroll reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传图片失败！")];
        }
    }];
}

@end
