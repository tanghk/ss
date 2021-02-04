//
//  MTools.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CustomBtnImgPos) {//按钮的img相对于title的位置
    BtnImgPosTop,       //img在上，title在下
    BtnImgPosLeft,      //img在左，title在右
    BtnImgPosBottom,    //img在下，title在上
    BtnImgPosRight      //img在右，title在左
};

@interface MTools : NSObject

#pragma mark - 参数字典转换请求参数字符串
+(NSString *)parseDictionaryToFormattedString:(NSDictionary *)dic;

#pragma mark - 将a=1&b=2&c=3 格式字符串转换成字典
+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding;

#pragma mark - 字典转json字符串
+(NSString *)parseToJsonString:(id)jsonObject;

#pragma mark - json字符串转字典
+(NSDictionary *)dictionaryWithString:(NSString *)string;
+(NSArray *)arrayWithJsonString:(NSString *)string;


#pragma mark -  创建Label

+(UILabel *)creatLblWithFont:(UIFont *)font TextColor:(UIColor *)textColor;

/*
 方法:网络图片转换为图片对象
 */
+ (UIImage *)getImageFromUrl:(NSString *)imgUrl;

#pragma mark - 创建UIButton
+(UIButton *)createButtonWithTitle:(NSString *)title Font:(UIFont *)font TitleColor:(UIColor *)titleColor;

+(UIButton *)createButtonWithImage:(UIImage *)image;

#pragma mark - 创建颜色View
+(UIView *)createViewWithColor:(UIColor *)color;

#pragma mark - 绘制虚线

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;



//首页更改新春色新增的方法
+(UIButton *)createGradentNewButtonWithTitle:(NSString *)title Font:(UIFont *)font TitleColor:(UIColor *)titleColor frame:(CGRect)frame;


@end
