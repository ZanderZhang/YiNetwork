//
//  ViewController.m
//  YiNetwork
//
//  Created by coderyi on 15/9/15.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "ViewController.h"
#import "YiUploadImageRequest.h"
#import "YiUserInfoModel.h"
#import "YiGetUserInfoRequest.h"
#import "YiModifyUserInfoRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    
    //通过GET请求获取用户信息
    YiGetUserInfoRequest *getUserInfoRequest=[[YiGetUserInfoRequest alloc] init];
    [getUserInfoRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
        
        NSLog(@"username is %@",((YiUserInfoModel *)model).name);
        
    } failure:^(NSError *error,NSURLSessionTask *task){
        
    }];
    
}

-(void)modifyUserInfo{

    
    //通过POST请求修改用户信息
    YiModifyUserInfoRequest *modifyUserInfoRequest=[[YiModifyUserInfoRequest alloc] initWithNameId:@"coderyi"];
    [modifyUserInfoRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
        
        NSLog(@"username is %@",((YiUserInfoModel *)model).name);
        
    } failure:^(NSError *error,NSURLSessionTask *task){
        
    }];

}

- (void)uploadImage{
    //上传一张图片
        UIImage *image;
        YiUploadImageRequest *uploadImageRequest=[[YiUploadImageRequest alloc] initWithImage:image];
        [uploadImageRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
            NSLog(@"model is %@",model);
    
        } failure:^(NSError *error,NSURLSessionTask *task){
            
        }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
