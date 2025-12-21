//
//  StoreDetailInfoTable.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreDetailInfoTable.h"
#import "StoreProfileTableViewCell.h"
#import "StoreDetailImageModel.h"

@interface StoreDetailInfoTable()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation StoreDetailInfoTable
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor  = kRGB_COLOR(@"#F4F4F4");
    }
    return self;
}
- (void)setBusiness:(ShopBusinessModel *)business{
    _business = business;
    for (int i = 0; i < 3; i++) {
        StoreDetailSectionModel *sectionModel = [[StoreDetailSectionModel alloc]init];
        sectionModel.model = business;
        sectionModel.section = i;
        if (i == 0) {
            sectionModel.title = kLocalizationMsg(@"商家简介");
        }else if(i == 1){
            sectionModel.title = kLocalizationMsg(@"商家承诺");
        }else{
            sectionModel.title = kLocalizationMsg(@"营业执照");
        }
        sectionModel.height =[self getCellHeight:i sectionModel:sectionModel];
        [self.dataArray addObject:sectionModel];
    }
}
- (CGFloat)getCellHeight:(int)index sectionModel:(StoreDetailSectionModel *)sectionModel{
    __block CGFloat height = 0.0f;
    kWeakSelf(sectionModel);
    kWeakSelf(self);
    if (index == 0) {//商家简介
        height += 12;
        height += 40;
        if (self.business.present.length > 0) {
            CGSize size = [self.business.present boundingRectWithSize:CGSizeMake(kScreenWidth-48, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            if (size.height + 10 > 40) {
                height += size.height+10;
            }else{
                height += 40;
            }
        }
        if (self.business.presentPicture.length > 0) {
            NSArray *arr = [self.business.presentPicture componentsSeparatedByString:@","];
            
            __block NSMutableArray *imageArr = [NSMutableArray array];
            for (__block int i = 0; i < arr.count; i++) {
                NSString *url = arr[i];
                StoreDetailImageModel *sub = [[StoreDetailImageModel alloc]init];
                sub.url = url;
                [imageArr addObject:sub];
                [self getWebImageWith:url index:i callBack:^(BOOL success,NSInteger idx, UIImage *image) {
                    UIImageView *imageV;
                    CGFloat imageH;
                    StoreDetailImageModel *subModel = [[StoreDetailImageModel alloc]init];
                    if (success) {
                        imageH = (kScreenWidth-24)*image.size.height*1.0/image.size.width;
                        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth-24, imageH)];
                    }else{
                        imageH = (kScreenWidth-24);
                        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, imageH, imageH)];
                    }
                    imageV.backgroundColor = [UIColor lightGrayColor];
                    imageV.clipsToBounds = YES;
                    imageV.contentMode = UIViewContentModeScaleAspectFill;
                    imageV.image = image;
                    subModel.width = (kScreenWidth-24);
                    subModel.height = imageH;
                    subModel.imageV = imageV;
                    [imageArr  replaceObjectAtIndex:idx withObject:subModel];
                    height += imageH;
                    weaksectionModel.height = height;
                    weaksectionModel.images = [NSArray arrayWithArray:imageArr];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself reloadData];
                    });
                }];
            }
            
        }
        
        
    }else if(index == 1){//承诺
        return 132;
    }else{//商家营业执照
        height += 24+40;
        if (self.business.businessLicense.length > 0) {
            NSArray *arr = [self.business.businessLicense componentsSeparatedByString:@","];
            __block NSMutableArray *imageArr = [NSMutableArray array];
            for (__block int i = 0; i < arr.count; i++) {
                NSString *url = arr[i];
                StoreDetailImageModel *sub = [[StoreDetailImageModel alloc]init];
                sub.url = url;
                [imageArr addObject:sub];
                [self getWebImageWith:url index:i callBack:^(BOOL success,NSInteger idx, UIImage *image) {
                    UIImageView *imageV;
                    CGFloat imageH;
                    StoreDetailImageModel *subModel = [[StoreDetailImageModel alloc]init];
                    if (success) {
                        imageH = (kScreenWidth-24)*image.size.height*1.0/image.size.width;
                        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth-24, imageH)];
                    }else{
                        imageH = (kScreenWidth-24);
                        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, imageH, imageH)];
                    }
                    imageV.backgroundColor = [UIColor lightGrayColor];
                    imageV.contentMode = UIViewContentModeScaleAspectFill;
                    imageV.image = image;
                    subModel.width = (kScreenWidth-24);
                    subModel.height = imageH;
                    subModel.imageV = imageV;
                    [imageArr  replaceObjectAtIndex:idx withObject:subModel];
                    height += imageH;
                    weaksectionModel.height = height;
                    weaksectionModel.images = [NSArray arrayWithArray:imageArr];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself reloadData];
                    });
                }];
            }
            
        }
        
    }
    return height;
}
- (void)getWebImageWith:(NSString *)url index:(NSInteger)index callBack:(void(^)( BOOL success,NSInteger idx,UIImage *image))callBack{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //       // NSLog(@"过滤文字receive == %ld targetURL == %@"),(long)receivedSize,targetURL);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (error) {
            callBack(NO,index,nil);
        } else {
            callBack(YES,index,image);
        }
    }];
}
#pragma mark - tableveiw
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailSectionModel *sectionModel;
    if (indexPath.row < self.dataArray.count) {
        sectionModel = self.dataArray[indexPath.row];
    }
    if (indexPath.row == 0) {
        StoreProfileTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[StoreProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreProfileTableViewCell"];
        }
        if (sectionModel) {
            cell.sectionModel = sectionModel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 1){
        StorePromiseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[StorePromiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StorePromiseTableViewCell"];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        StoreLicenseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[StoreLicenseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreLicenseTableViewCell"];
        }
        if (sectionModel) {
            cell.sectionModel = sectionModel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailSectionModel *sectionModel;
    if (indexPath.row < self.dataArray.count) {
        sectionModel = self.dataArray[indexPath.row];
    }
    return sectionModel.height;
}

#pragma mark - JXPagerViewListViewDelegate
- (void)listDidAppear{
    [self reloadData];
}
- (UIScrollView *)listScrollView {
    return self;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (UIView *)listView {
    return self;
}
@end
