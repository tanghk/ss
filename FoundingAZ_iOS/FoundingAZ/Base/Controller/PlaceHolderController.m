//
//  PlaceHolderController.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "PlaceHolderController.h"

@interface PlaceHolderController ()

@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic, strong) UIImageView *placeImageV;
@property (nonatomic, strong) UILabel *placeLabel;

@end

@implementation PlaceHolderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithData{
    [super initWithData];
}

- (void)initWithNaviUI{
    [super initWithNaviUI];
}

- (void)initWithMainUI{
    [super initWithMainUI];
}

#pragma mark 没有数据占位
- (void)noData_placeHolder{
    
    [self.view addSubview:self.placeHolderView];
    [self.placeHolderView addSubview:self.placeImageV];
    [self.placeHolderView addSubview:self.placeLabel];
    
    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(kTopHeight);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.placeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(130, 140));
        make.centerX.equalTo(self.placeHolderView);
        make.centerY.equalTo(self.placeHolderView).with.offset(-70);
    }];
    
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.placeHolderView);
        make.top.equalTo(self.placeImageV.mas_bottom).with.offset(20);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark webview占位
- (void)noWebView_placeHolder{
    
    [self.view addSubview:self.placeHolderView];
    [self.placeHolderView addSubview:self.placeImageV];
    [self.placeHolderView addSubview:self.reloadPlaceHolderBtn];
    
    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    [self.placeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(130, 140));
        make.centerX.equalTo(self.placeHolderView);
        make.centerY.equalTo(self.placeHolderView).with.offset(-70);
    }];
    
    [self.reloadPlaceHolderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.placeHolderView);
        make.top.equalTo(self.placeImageV.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark 移除占位图
- (void)removePlaceHolderView{
    
    [self.placeHolderView removeFromSuperview];
}

/*
 * creat placeHolderView
 */
- (UIView *)placeHolderView{
    
    if (!_placeHolderView) {
        _placeHolderView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _placeHolderView;
}

/*
 * creat placeImageV
 */
- (UIImageView *)placeImageV{
    
    if (!_placeImageV) {
        _placeImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_noData_imge"];
    }
    
    return _placeImageV;
}

/*
 * creat placeLabel
 */
- (UILabel *)placeLabel{
    
    if (!_placeLabel) {
        _placeLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:16.0] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"暂无更多数据"];
    }
    
    return _placeLabel;
}

/*
 * creat reloadPlaceHolderBtn
 */
- (UIButton *)reloadPlaceHolderBtn{
    
    if (!_reloadPlaceHolderBtn) {
        _reloadPlaceHolderBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainBlue font:[UIFont M_PingFang_RegularOfSize:16.0] backgroundColor:[UIColor whiteColor] title:@"点击重新载入"];
    }
    
    return _reloadPlaceHolderBtn;
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
