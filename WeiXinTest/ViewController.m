//
//  ViewController.m
//  WeiXinTest
//
//  Created by guodong on 2018/12/5.
//  Copyright © 2018年 Maizi. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"BindWeiXin";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}


- (IBAction)clickBtn:(id)sender {
    [self sendAuthRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
