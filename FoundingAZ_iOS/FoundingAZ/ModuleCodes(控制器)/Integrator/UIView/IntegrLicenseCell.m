//
//  IntegrLicenseCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegrLicenseCell.h"
#import "IntegrEnterModel.h"
#import "IntegUploadLiceView.h"

@interface IntegrLicenseCell ()

@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *uploadBtn;

@property (nonatomic, strong) IntegrEnterModel *tModel;

@end

@implementation IntegrLicenseCell

- (void)configSubView{
    
    UIImageView *lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    lineImageV.backgroundColor = Color_Separator;
    [self addSubview:lineImageV];
    self.lineImageV = lineImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *uploadBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_RegularOfSize:Font_12] backgroundColor:Color_MainBlue title:@"去上传"];
    ViewRadius(uploadBtn, 4.0);
    [uploadBtn addTarget:self action:@selector(uploadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:uploadBtn];
    self.uploadBtn = uploadBtn;
}

- (void)layout{
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(17);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(64);
    }];
    
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-16);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(72, 30));
    }];
}

- (void)configureCellWithModel:(IntegrEnterModel *)contentModel{
    
    self.tModel = contentModel;
    
    self.titleLabel.text = contentModel.title;
}

#pragma mark 上传按钮点击事件
- (void)uploadBtnClick{
    
    IntegUploadLiceView *vc = [[IntegUploadLiceView alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.viewController presentViewController:vc animated:NO completion:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
