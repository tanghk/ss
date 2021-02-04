//
//  AppVariable.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#ifndef AppVariable_h
#define AppVariable_h
#pragma mark - ---------------------颜色定义---------------------
//颜色-快捷定义
#define kWhiteColor(white,alph)             [UIColor colorWithWhite:white alpha:alph]
#define kColor(color)                       [UIColor color]
#define kColorFromRGB(r,g,b)                [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kColorFromSameRGB(value)            [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:1.0]
#define kColorFromHex(string)               [UIColor colorWithHexString:string]
/*
 * 颜色相关
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXACOLOR(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//预定义颜色-NavBar
#define Color_NavBarTitle                   Color_333 //导航标题文字颜色
#define Color_NavBarBg                      [UIColor whiteColor]//导航栏背景的颜色
#define Color_NavBarButtonTint              Color_333//[UIColor whiteColor]//导航栏标题及导航按钮的颜色：白色

#define MainColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//TabBar
#define Color_TbUnSelectTintColor           [UIColor colorWithHexString:@"787d83"]
#define Color_TbSelectTintColor             [UIColor colorWithHexString:@"40A1F6"]//7c9a3d

//view-background
#define Color_ViewBg                    kColorFromHex(@"f1f1f1")
#define Color_Blue                      Color_TbSelectTintColor
//黑色3333
#define Color_MainBlack                 kColorFromHex(@"333333")

//灰色0
#define Color_MainGray                  kColorFromHex(@"999999")
//灰色字
#define Color_Font                      kColorFromHex(@"666666")

#define Color_CourseRed                 [UIColor colorWithHexString:@"#F5330F"]

//灰色1
#define Color_MainGray_one              kColorFromHex(@"CCCCCC")
//红色
#define Color_MainRed                   kColorFromHex(@"#F25A00")
//分割线颜色
#define Color_Separator                 kColorFromHex(@"#EBEBEB")
#define Color_Separator                 kColorFromHex(@"#EBEBEB")
//背景色
#define Color_MainGroud                 kColorFromHex(@"#F7F8FA")

//蓝色
#define Color_MainBlue                  HEXACOLOR(0x2B75FF,1)





//灰色2
#define Color_MainGray_Two              HEXACOLOR(0xD3D3D7,1)


//白色
#define Color_Whitle                  kColorFromHex(@"ffffff")

#define Color_333                           kColorFromHex(@"333333")//：黑色
#define Color_666                           kColorFromHex(@"666666")//灰色(tabbar灰色图标)
#define Color_999                           kColorFromHex(@"999999")//灰色
#define Color_888                           kColorFromHex(@"888888")//灰色
#define Color_bbb                           kColorFromHex(@"bbbbbb")
#define Color_ccc                           kColorFromHex(@"cccccc")//浅灰色
#define Color_eee                           kColorFromHex(@"eeeeee")
#define Color_fff                           kColorFromHex(@"ffffff")

/*
 * 字体相关
 */
//字体-快捷定义
#define kFont(font)                         [UIFont systemFontOfSize:font]
#define BoldFont(xxx)                       [UIFont boldSystemFontOfSize:xxx]

//字符串-快捷定义
#define FormatNumber(num)                   [NSString stringWithFormat:@"%@",@(num)]
#define FormatString(string)                [NSString stringWithFormat:@"%@",string]
#define kURL(string)                        [NSURL URLWithString:string]

// 空值判断
#define IsNullObject(obj) (obj == nil || obj == Nil || obj == NULL || [obj isKindOfClass:[NSNull class]] || ![obj isKindOfClass:[NSObject class]])


#define IsNullDictionary(dict) (IsNullObject(dict) || ![dict isKindOfClass:[NSDictionary class]] || [dict count] == 0)

#define Font_10                     10.0
#define Font_11                     11.0
#define Font_12                     12.0
#define Font_13                     13.0
#define Font_14                     14.0
#define Font_15                     15.0
#define Font_16                     16.0
#define Font_17                     17.0
#define Font_18                     18.0
#define Font_19                     19.0
#define Font_20                     20.0
#define Font_22                     22.0
#define Font_24                     24.0


/*
 * 间距相关
 */
//主题间距
#define CustomSpaceWith             20.0

#define HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"History.plist"] // the path of search record cached
/*
 * 提示语相关
 */

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#endif /* AppVariable_h */
