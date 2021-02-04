//
//  Utility.m
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "Utility.h"
#import "AuthTools.h"
#import "UICKeyChainStore.h"

@implementation Utility

#pragma mark - 初始化请求公共参数(数据请求时公共的或每次必传的一些参数)

+(NSMutableDictionary *)initPublicParames{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (!isNil([Utility getUserToken])) {//登录状态必传
        parameters[@"token"] = [Utility getUserToken];
    }

    
    return parameters;
}

#pragma mark - 用户数据 - 当前用户


// 缓存签名串Token，每次登录的时候缓存该Token
+(void)saveUserToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setValue:null(token, @"") forKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(NSString *)getUserToken{
    NSString *saved = [[NSUserDefaults standardUserDefaults] valueForKey:@"userToken"];
    return isNil(saved)?@"":saved;
    
}

+(void)deleteUserToken{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
}

/**
 *  @brief  缓存用户的ID
 */
+(void)saveUserId:(NSString *)userId{
    
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    [keyChain setString:null(userId, @"") forKey:@"userId"];
}

+(NSString *)getUserId{

    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    NSString *strUserId = [keyChain stringForKey:@"userId"];
    
    return strUserId;
}

+(void)deleteUserId{
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    [keyChain removeItemForKey:@"userId"];
}

/**
 *  @brief  缓存用户名
 */
+(void)saveUserName:(NSString *)userName{
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    [keyChain setString:null(userName, @"") forKey:@"userName"];
}

+(NSString *)getUserName{
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    NSString *userName = [keyChain stringForKey:@"userName"];
    return null(userName, @"");
}

+(void)deleteUserName{
    UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStore];
    [keyChain removeItemForKey:@"userName"];
}

/**
 *  @brief  缓存用户的登录帐号
 */
+(void)saveUserAccount:(NSString *)userAccount{
    [[NSUserDefaults standardUserDefaults] setValue:null(userAccount, @"") forKey:@"userAccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getUserAccount{
    NSString *userAccount = [[NSUserDefaults standardUserDefaults] valueForKey:@"userAccount"];
    return null(userAccount, @"");
}

+(void)deleteUserAccount{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userAccount"];
}

/**
 *  @brief  缓存用户的密码
 */
+(void)saveUserPwd:(NSString *)userPwd{
    [[NSUserDefaults standardUserDefaults] setValue:null(userPwd, @"") forKey:@"userPwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getUserPwd{
    NSString *userPwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"userPwd"];
    return null(userPwd, @"");
}

+(void)deleteUserPwd{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPwd"];
}

/**
 *  @brief  缓存用户头像URL
 */
+(void)savePhotoUrl:(NSString *)photoUrl{
    [[NSUserDefaults standardUserDefaults] setValue:null(photoUrl, @"") forKey:@"userPhoto"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getPhotoUrl{
    NSString *userPhoto = [[NSUserDefaults standardUserDefaults] valueForKey:@"userPhoto"];
    return null(userPhoto, @"");
}

+(void)deletePhotoUrl{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhoto"];
}


#pragma mark - 退出帐号时，删除本地缓存信息

+(void)deleteLocalUserInfo{
    
    [Utility deleteUserId];
    [Utility deleteUserName];
    [Utility deleteUserToken];
    [Utility deletePhotoUrl];
}


#pragma mark - 当前定位城市名字

+(void)saveLocatedCityName:(NSString *)cityName;{
    
    [[NSUserDefaults standardUserDefaults] setValue:null(cityName, @"") forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getLocatedCityName{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
    return null(cityName, @"");
}

#pragma mark - 当前定位城市经纬度

+(void)saveLocatedLon:(NSString *)lon Lat:(NSString *)lat{
    
    if (isNil(lon) || isNil(lat)) {
        return;
    }
    NSDictionary *xyPoint = @{@"longitude":lon,
                              @"latitude":lat
                              };
    [[NSUserDefaults standardUserDefaults] setValue:xyPoint forKey:@"location"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"保存经纬度");
//    if (isNil([Utility getLocatedLongitude])) {
//        
//    }
}

+(NSString *)getLocatedLongitude{
    NSString *lon = @"0";
    
    NSDictionary *xyPoint = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"];
    if (!isNil(xyPoint[@"longitude"])) {
        lon = xyPoint[@"longitude"];
    }
    
    return lon;
}

+(NSString *)getLocatedLatitude{
    NSString *lat = @"0";
    
    NSDictionary *xyPoint = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"];
    if (!isNil(xyPoint[@"latitude"])) {
        lat = xyPoint[@"latitude"];
    }
    
    return lat;
}

+(void)deleteLocated{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"location"];
}

#pragma mark - 添加引导页第一次启动标识

+(void)setFirstLaunchFlag:(NSString *)flag{
    [[NSUserDefaults standardUserDefaults] setValue:null(flag, @"") forKey:@"FirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getFirstLaunchFlag{
    NSString *flag = [[NSUserDefaults standardUserDefaults] valueForKey:@"FirstLaunch"];
    return null(flag, @"");
}


@end
