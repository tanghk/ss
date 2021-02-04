//
//  CusSearchBar.m
//  iMuGou
//
//  Created by 九博 on 2017/5/10.
//  Copyright © 2017年 imugou. All rights reserved.
//

#import "CusSearchBar.h"

#define ImgSearchWidth   22
#define ImgSearchHeight  22

@implementation CusSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
                
        _imgSearch = [UIImageView new];
        _imgSearch.frame = CGRectMake(12, (self.frameHeight - ImgSearchHeight)/2, ImgSearchWidth, ImgSearchHeight);
        _imgSearch.image = kImage(@"Course_Search");
        [self addSubview:_imgSearch];
        
        _textField = [CusTextField new];
        _textField.frame = CGRectMake(_imgSearch.frameRight + 7, 0, self.frameWidth - _imgSearch.frameRight - 7 - 7, self.frameHeight);
        [self addSubview:_textField];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame DidClickSearch:(DidSearchAction)didClickSearch
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _didSearchAction = didClickSearch;
        
        _imgSearch = [UIImageView new];
        _imgSearch.frame = CGRectMake(12, (self.frameHeight - ImgSearchHeight)/2, ImgSearchWidth, ImgSearchHeight);
        _imgSearch.image = kImage(@"Course_Search");
        [self addSubview:_imgSearch];
        
        _textField = [CusTextField new];
        _textField.frame = CGRectMake(_imgSearch.frameRight + 7, 0, self.frameWidth - _imgSearch.frameRight - 14, self.frameHeight);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        [self addSubview:_textField];
        
    }
    return self;
}

//-(void)setImageSize:(CGFloat)imageSize{
//    _imageSize = imageSize;
//    _imgSearch.frameWidth = imageSize.;
//    _imgSearch.frameY = (self.frameHeight - imageSize)/2;
//}

-(void)setSearchTextAlignmentMiddle:(BOOL)SearchTextAlignmentMiddle{
    
    if (SearchTextAlignmentMiddle) {
       
         CGFloat textWidth = tWidthByFont(_textField.font , _textField.placeholder);
        _textField.frameWidth = textWidth + 20;
        _imgSearch.frameX = (self.frameWidth - (_imgSearch.frameWidth + 5 + textWidth))/2;
        _textField.frameX = _imgSearch.frameRight + 5;
    }else{
        _imgSearch.frameX = 10;
        _textField.frameX = _imgSearch.frameRight + 5;
        _textField.frameWidth = self.frameWidth - _textField.frameX;
    }
}

-(void)setEnableDelegate:(NSInteger)enableDelegate{
    
    if (enableDelegate) {
        _textField.delegate = self;
    }else{
        _textField.delegate = nil;
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
//    _didBeginInput();
//    if (self.SearchTextAlignmentMiddle) {
//        [self setSearchTextAlignmentMiddle:NO];
//    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _didSearchAction(textField.text);
    return YES;
}

@end
