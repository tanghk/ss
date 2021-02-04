//
//  HomeTableCell.m
//  FoundingAZ
//
//  Created by mark on 2021/1/28.
//

#import "HomeTableCell.h"
#import "HomeModel.h"
@interface HomeTableCell ()

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *conLabel;
@property (nonatomic, strong) UIView *topCornerView;
@property (nonatomic, strong) UIView *bottomCornerView;

@end
@implementation HomeTableCell


- (void)configSubView{
    
    self.backgroundColor = Color_MainGroud;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectZero];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    
    UIView *topCornerView = [[UIView alloc] initWithFrame:CGRectZero];
    ViewRadius(topCornerView, 8.0);
    topCornerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topCornerView];
    self.topCornerView = topCornerView;
    
    UIView *bottomCornerView = [[UIView alloc] initWithFrame:CGRectZero];
    ViewRadius(bottomCornerView, 8.0);
    bottomCornerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomCornerView];
    self.bottomCornerView = bottomCornerView;
    
    UIImageView *lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    lineImageV.backgroundColor = Color_Separator;
    [self addSubview:lineImageV];
    self.lineImageV = lineImageV;
    
    UIImageView *iconImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    [self addSubview:iconImageV];
    self.iconImageV = iconImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_arrow_right"];
    [self addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
    
    UILabel *conLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainGray_one textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor] text:@""];
    conLabel.hidden = YES;
    [self addSubview:conLabel];
    self.conLabel = conLabel;
}

- (void)layout{
    
//    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.mas_equalTo(12);
//        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-12);
//        make.bottom.mas_equalTo(-10);
//    }];
//    
//    [self.topCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.mas_equalTo(12);
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(-12);
//        make.bottom.mas_equalTo(-10);
//    }];
//    
//    [self.bottomCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.mas_equalTo(12);
//        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-12);
//        make.bottom.mas_equalTo(0);
//    }];
//    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(12+12);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageV.mas_right).with.offset(10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(22);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(-20);
    }];
    
    [self.conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.right.equalTo(self.arrowImageV.mas_left).with.offset(-4);
        make.width.mas_equalTo(150);
    }];
}

- (void)configureCellWithModel:(HomeModel *)contentModel withIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array{
    
    self.titleLabel.text = contentModel.title;
    self.iconImageV.image = [UIImage imageNamed:contentModel.iconImageStr];
    
   
    
//    if (indexPath.row == 0) {
//        ViewRadius(self.topCornerView, 8.0);
//        if (array.count == 1) {
//            ViewRadius(self.bottomCornerView, 8.0);
//        }else{
//            ViewRadius(self.bottomCornerView, 0.0);
//        }
//    }else if(indexPath.row == array.count -1){
//        ViewRadius(self.topCornerView, 0.0);
//        ViewRadius(self.bottomCornerView, 8.0);
//    }else{
//        ViewRadius(self.topCornerView, 0.0);
//        ViewRadius(self.bottomCornerView, 0.0);
//    }
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
