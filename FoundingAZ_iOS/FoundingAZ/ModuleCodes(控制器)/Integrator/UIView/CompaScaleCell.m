//
//  CompaScaleCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "CompaScaleCell.h"

@interface CompaScaleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CompaScaleCell

- (void)configSubView{
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor randomColor] text:@"1-10人"];
    ViewRadius(titleLabel, 4.0);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)layout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    
    
}

@end
