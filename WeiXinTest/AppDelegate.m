//
//  AppDelegate.m
//  WeiXinTest
//
//  Created by guodong on 2018/12/5.
//  Copyright © 2018年 Maizi. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"


static NSString * const nnWxAppId = @"wx090f6002788ff6f9";
static NSString * const nnWxAppSecret = @"xxxxx";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     [WXApi registerApp:@"wx090f6002788ff6f9"];
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
    
}

-(void) onReq:(BaseReq*)reqonReq
{
    NSLog(@"reqonReq:%@",reqonReq);
}

- (void) onResp:(BaseResp*)resp{
    NSLog(@"resp.errCode = %d",resp.errCode);
    NSLog(@"resp.errCode = %@",resp.errStr);
    NSLog(@"resp.errCode = %d",resp.type);
    
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    
    if(aresp.errCode== 0 && [aresp.state isEqualToString:@"BindWeiXin"])
    {
        NSString *code = aresp.code;
        [self getWeiXinOpenId:code];
    }
    
}


- (void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",nnWxAppId,nnWxAppSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *openID = dic[@"openid"];
                NSString *unionid = dic[@"unionid"];
            }
        });
    });
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
