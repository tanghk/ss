//
//  CusTextField.m
//  iMuGou
//
//  Created by 九博 on 2017/5/10.
//  Copyright © 2017年 imugou. All rights reserved.
//

#import "CusTextField.h"

@implementation CusTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.spellCheckingType = UITextSpellCheckingTypeNo;
    }
    return self;
}


-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
//    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:null(self.placeholder, @"") attributes:@{NSForegroundColorAttributeName: placeHolderColor}];

}

-(void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    
    _placeHolderFont = placeHolderFont;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:null(self.placeholder, @"") attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]}];
}


@end
