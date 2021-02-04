//
//  Utility.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//



#import <Foundation/Foundation.h>


@interface Utility : NSObject


#pragma mark - 初始化请求公共参数

+(NSMutableDictionary *)initPublicParames;

#pragma mark - 用户数据 - UserToken

/**
 *  @brief  UserToken
 */
+(void)saveUserToken:(NSString *)token;
+(NSString *)getUserToken;
+(void)deleteUserToken;
#pragma mark - 用户数据 - 当前用户

/**
 *  @brief  缓存用户的ID
 */
+(void)saveUserId:(NSString *)userId;

+(NSString *)getUserId;

+(void)deleteUserId;

/**
 *  @brief  缓存用户名
 */
+(void)saveUserName:(NSString *)userName;

+(NSString *)getUserName;

+(void)deleteUserName;

/**
 *  @brief  缓存用户的登录帐号
 */
+(void)saveUserAccount:(NSString *)userAccount;

+(NSString *)getUserAccount;

+(void)deleteUserAccount;

/**
 *  @brief  缓存用户的密码
 */
+(void)saveUserPwd:(NSString *)myPwd;

+(NSString *)getUserPwd;

+(void)deleteUserPwd;

/**
 *  @brief  缓存用户头像URL
 */
+(void)savePhotoUrl:(NSString *)photoUrl;

+(NSString *)getPhotoUrl;

+(void)deletePhotoUrl;


#pragma mark - 退出帐号时，删除本地缓存信息

+(void)deleteLocalUserInfo;

#pragma mark - 当前定位城市名字

+(void)saveLocatedCityName:(NSString *)cityName;

+(NSString *)getLocatedCityName;

#pragma mark - 当前定位城市经纬度

+(void)saveLocatedLon:(NSString *)lon Lat:(NSString *)lat;

+(NSString *)getLocatedLongitude;

+(NSString *)getLocatedLatitude;

+(void)deleteLocated;

#pragma mark - 添加引导页第一次启动标识

+(void)setFirstLaunchFlag:(NSString *)flag;

+(NSString *)getFirstLaunchFlag;



@end
