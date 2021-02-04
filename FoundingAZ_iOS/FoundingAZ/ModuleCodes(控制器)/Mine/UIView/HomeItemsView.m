//
//  HomeItemsView.m
//  FoundingAZ
//
//  Created by mark on 2021/1/27.
//

#import "HomeItemsView.h"
#import "HomeItemsCell.h"


static NSString *HomeItemsCell_ID = @"homeItemsCell_ID";

@interface HomeItemsView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *hLineImageV;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeItemsView


- (void)configSubView{
    
    ViewRadius(self, 8.0);
    NSArray *titleOneArr = @[@"酵母简介",@"酵母客户",@"培训服务",@"在线咨询",@"成功案例"];
    self.dataArray =[NSMutableArray arrayWithArray:titleOneArr];
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"我的项目"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_arrow_right"];
    [self addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
    
    UILabel *allLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainGray_one textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor] text:@"全部项目"];
    [self addSubview:allLabel];
    self.allLabel = allLabel;
    
    UIImageView *hLineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    hLineImageV.backgroundColor = Color_Separator;
    [self addSubview:hLineImageV];
    self.hLineImageV = hLineImageV;
    
    [self addSubview:self.collectionView];
}

- (void)layout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(12);
        make.height.mas_equalTo(22);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(-8);
    }];
    
    [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.arrowImageV.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.hLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(15);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
}

- (void)configureViewWithModel:(id)contentModel{
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
       
    return 5;//self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreen_Width-2*12)/5, 84);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//横向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0;
}

//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeItemsCell_ID forIndexPath:indexPath];
    
    [cell configureCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
 *creat collectionView
 */
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        } else {
            //Fallback on earlier versions
        }
        
        [_collectionView registerClass:[HomeItemsCell class] forCellWithReuseIdentifier:HomeItemsCell_ID];
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
