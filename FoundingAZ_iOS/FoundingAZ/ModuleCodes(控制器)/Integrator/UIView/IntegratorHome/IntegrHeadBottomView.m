//
//  IntegrHeadBottomView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegrHeadBottomView.h"
#import "IntegCreatCaseVC.h"

@interface IntegrHeadBottomView ()

@property (nonatomic, strong) UIView *spaceView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *creatBtn;

@end

@implementation IntegrHeadBottomView

- (void)configSubView{
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectZero];
    spaceView.backgroundColor = Color_MainGroud;
    [self addSubview:spaceView];
    self.spaceView = spaceView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_18] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"应用案例"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *creatBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainBlue font:[UIFont M_PingFang_RegularOfSize:Font_12] backgroundColor:[UIColor whiteColor] title:@"+ 新建"];
    ViewBorderRadius(creatBtn, 12, 0.5, Color_MainBlue);
    [creatBtn addTarget:self action:@selector(creatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:creatBtn];
    self.creatBtn = creatBtn;
}

- (void)layout{
    
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(12);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
    [self.creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-16);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(56, 24));
    }];
}

- (void)configureViewWithModel:(id)contentModel{
    
    
}

#pragma mark 新建按钮点击事件
- (void)creatBtnClick{
    
    IntegCreatCaseVC *vc = [[IntegCreatCaseVC alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
