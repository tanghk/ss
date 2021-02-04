//
//  CompaScaleVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "CompaScaleVC.h"
#import "CompaScaleCell.h"

static NSString *CompaScaleCell_ID = @"compaScaleCell_ID";

#define CompaScaleGroudHeight      (230+68)

@interface CompaScaleVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *backGroudView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CompaScaleVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backGroudView.frame = CGRectMake(0, kScreen_Height-kBottomHeight-CompaScaleGroudHeight, kScreen_Width, CompaScaleGroudHeight+kBottomHeight);
    } completion:^(BOOL finished) {
        self.nextBtn.hidden = NO;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    // Do any additional setup after loading the view.
}

#pragma mark 关闭点击事件
- (void)closeBtnClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backGroudView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, CompaScaleGroudHeight+kBottomHeight);
        self.nextBtn.hidden = YES;
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark 确定按钮点击事件
- (void)nextBtnClick{
    
    [MBProgressHUD showMessageInWindow:@"确定"];
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.backGroudView];
    [self.backGroudView addSubview:self.lineImageV];
    [self.backGroudView addSubview:self.titleLabel];
    [self.backGroudView addSubview:self.cancleBtn];
    [self.backGroudView addSubview:self.collectionView];
    [self.view addSubview:self.nextBtn];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.backGroudView.mas_top).with.offset(57);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.backGroudView.mas_top).with.offset(16);
        make.centerX.equalTo(self.backGroudView);
        make.height.mas_equalTo(25);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(44, 44));//24*24
        make.right.mas_equalTo(-12+10);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.backGroudView);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(-kBottomHeight-68);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
       
    return 9;//self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreen_Width-2*16-2*13)/3, 32);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(24, 16, 24, 16);
}

//横向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 13.0;
}

//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 13.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompaScaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CompaScaleCell_ID forIndexPath:indexPath];
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
 * creat closeBtn
 */
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [UIButton createButtonWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-CompaScaleGroudHeight-kBottomHeight) normalImage:@""];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _closeBtn;
}

/*
 * creat backGroudView
 */
- (UIView *)backGroudView{
    
    if (!_backGroudView) {
        _backGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, CompaScaleGroudHeight+kBottomHeight)];
        [_backGroudView roundCorner:UIRectCornerTopLeft | UIRectCornerTopRight radius:12.0];
        _backGroudView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backGroudView;
}

/*
 * creat lineImageV
 */
- (UIImageView *)lineImageV{
    
    if (!_lineImageV) {
        _lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _lineImageV.backgroundColor = Color_Separator;
    }
    
    return _lineImageV;
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_18] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"选择您的企业规模"];
    }
    
    return _titleLabel;
}

/*
 * creat cancleBtn
 */
- (UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        _cancleBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_close_24"];
        [_cancleBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _cancleBtn;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(16, kScreen_Height-kBottomHeight-10-48, kScreen_Width-2*16, 48) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_RegularOfSize:Font_18] backgroundColor:Color_MainBlue title:@"确定"];
        ViewShadow(_nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        _nextBtn.layer.cornerRadius = 8.0;
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
        
        NSArray *colorArray = @[(id)[HEXACOLOR(0x36A8FF, 1.0) CGColor],
                                (id)[HEXACOLOR(0x2A71FF, 1.0) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:8.0];
        [_nextBtn.layer addSublayer:nextBtnLayer];
        [_nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
    }
    
    return _nextBtn;
}

/*
 *creat collectionView
 */
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        } else {
            //Fallback on earlier versions
        }
        
        [_collectionView registerClass:[CompaScaleCell class] forCellWithReuseIdentifier:CompaScaleCell_ID];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
