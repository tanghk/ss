//
//  MineHeadView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "MineHeadView.h"
#import "MineItemsView.h"

@interface MineHeadView ()

@property (nonatomic, strong) UIImageView *groudImageV;
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) MineItemsView *mineItemsView;

@end

@implementation MineHeadView

- (void)configSubView{
    
    self.backgroundColor = Color_MainGroud;
    
    UIImageView *groudImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    [self addSubview:groudImageV];
    self.groudImageV = groudImageV;
    
    UIImageView *headImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"Mine_Header"];
    ViewRadius(headImageV, 35.0);
    headImageV.layer.borderWidth = 1;
    headImageV.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    [self addSubview:headImageV];
    self.headImageV = headImageV;
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_22] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor clearColor] text:@"微信昵称"];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    MineItemsView *mineItemsView = [[MineItemsView alloc] initWithFrame:CGRectZero];
    [self addSubview:mineItemsView];
    self.mineItemsView = mineItemsView;
}

- (void)layout{
    
    [self.groudImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-97);
    }];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(70+kStatusBarHeight);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.headImageV.mas_right).with.offset(10);
        make.centerY.equalTo(self.headImageV.mas_centerY);
        make.height.mas_equalTo(31);
        make.right.mas_equalTo(-15);
    }];
    
    
    [self.mineItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(86);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)configureViewWithModel:(id)contentModel{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
