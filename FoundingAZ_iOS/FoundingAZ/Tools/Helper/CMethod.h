//
//  CMethod.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//



#import <Foundation/Foundation.h>


#pragma mark - 获取当前Window

UIWindow *getKeyWindow(void);

#pragma mark - 判断字符串空的操作

NSString * null(NSString *strContent,NSString *strReplace);

BOOL isNil(NSString *string);

#pragma mark - 提示框

void showHUD(void);

void showWithText(NSString* text);

void showErrorTips(NSString *tips);

void showSuccessTips(NSString *tips);

void showInfoTips(NSString *tips);

void dismissHUD(void);

#pragma mark - 画线
UIView * drawHLine(UIColor *color,CGRect lineFrame);

#pragma mark - 获取Label文本宽度
CGFloat getLabelTextWidth(UILabel *label);

#pragma mark - 获取文字的大小
CGFloat getTextHeight(NSString *content,UIFont *font,CGFloat width);

CGFloat getTextHeightWithLineHeight(NSString *content,UIFont *font,CGFloat width, CGFloat lineHeight);

CGFloat getLabelTextHeight(UILabel *label, CGFloat lineHeight);

//单行文本高度
CGFloat tHeightByFont(UIFont* font);


//单行文本宽度
//CGFloat tWidthByFont(CGFloat fontSize,NSString *content);
CGFloat tWidthByFont(UIFont *font,NSString *content);


#pragma mark - 获取2倍3倍图片尺寸适配
CGFloat getRealPx(CGFloat f);

#pragma mark -
UIBarButtonItem *spaceButtonItem(CGFloat spaceWidth);

#pragma mark - pop push NavigationController页面

void popToViewController(Class toVC, UIViewController *currentVC,BOOL animate);

void popViewController(UIViewController *currentVC,BOOL animate);

void pushToViewController(UIViewController *currentVC,UIViewController *toView,BOOL animate);

#pragma mark - TableViewCell 扩展视图

UIImageView *customAccessoryView(NSString *imgName, CGSize size);

#pragma mark - 日期格式转化
NSDate * stringToDate(NSString *strDate,NSString *format);

NSString *FormatDateString(NSString *strDate,NSString *Format,NSString *toFormat);

NSString *FormatCurrentDate(NSString *strFormat);

NSString *FormatDate(NSDate *date,NSString *strFormat);

NSString *FormatDateTimeInterval(NSTimeInterval time,NSString *strFormat);

NSDate *FormatTimeIntervalToDate(NSTimeInterval time);

NSDate *getLastDayByDate(NSDate *date,NSInteger n);


#pragma mark - 文件操作

NSString *getDocumentPath(void);

NSString *getDirectoryPath(NSString *fileDirectory);

NSString *getFilePathByName(NSString *superPath,NSString *fileName);

BOOL deleteFileByName(NSString *superPath,NSString *fileName);

BOOL saveFileWithName(NSData *fileData, NSString *superPath,NSString *fileName);

UIImage *getPhotoFileByName(NSString *superPath,NSString *fileName);

long long fileSizeAtPath(NSString* filePath);

//遍历缓存文件夹获得文件夹大小，返回多少M
float folderSizeAtPath(NSString* folderPath);

#pragma mark - 设置可变属性字体

void addAttributeString(NSMutableAttributedString *mStrAttribute,NSString *strAttribute,UIColor *attColor,CGFloat attrFontSize);

NSMutableAttributedString * getMutableAttributeString(NSString *strContent,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize);

NSMutableAttributedString * getMutableAttributeStringWithLineHeight(NSString *strContent,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize, CGFloat lineHeight);

NSMutableAttributedString * getDeleteLineString(NSString *strContent,UIColor *lineColor);

NSMutableAttributedString * getAttributeStringWithLineHeight(NSString *strContent, CGFloat lineHeight);


void setLabelAttributeString(UILabel *label,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize);

#pragma mark - 打开网址

void openUrl(NSString *strUrl);


#pragma mark - 校验身份证号

BOOL checkIdentityNumber(NSString *identityNumber);

#pragma mark - 校验手机号

BOOL checkMobileValid(NSString *mobile);



@interface CMethod : NSObject

@end
