//
//  YiModifyUserInfoRequest.m
//  YiNetwork
//
//  Created by coderyi on 15/10/27.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "YiModifyUserInfoRequest.h"
#import "YiUserInfoModel.h"

@implementation YiModifyUserInfoRequest
-(instancetype)initWithNameId:(NSString *)nameId {
    self = [super init];
    if (self) {
        
        [self.postParams setValue:nameId forKey:@"name_id"];
        
    }
    return self;
}
- (NSString *)pathName
{
    return @"users/coderyi";
}
- (YiHTTPRequestMethod)requestMethod
{
    return YiHTTPRequestMethodPost;
}
- (YiBaseModel *)responseModelWithData:(id)data
{
    
    return [[YiUserInfoModel alloc] initWithDictionary:data error:nil];
}

@end
