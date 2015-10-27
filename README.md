# YiNetwork
[![Pod Version](http://img.shields.io/cocoapods/v/YiNetwork.svg?style=flat)](http://cocoadocs.org/docsets/YiNetwork/)
[![Pod Platform](http://img.shields.io/cocoapods/p/YiNetwork.svg?style=flat)](http://cocoadocs.org/docsets/YiNetwork/)
[![Pod License](http://img.shields.io/cocoapods/l/YiNetwork.svg?style=flat)](https://opensource.org/licenses/MIT)

YiNetwork是一个的HTTP请求封装库，基于AFNetworking的AFHTTPSessionManager。

YiNetwork主要是一个基类库，主要是两个类YiBaseRequest和YiBaseModel.

之所以创建两个基类，是为了让各个请求之间的耦合性降低，能够非常简单的实现一个请求，并且在上层很简单调用一个请求。每一个请求一个子类也非常能够方便团队协作，每个人都可以管理自己的请求模块。

另外，由于Apple在网络请求方面由NSURLConnection（iOS 2-9）转向NSURLSession（iOS7以上）,随之AFNetworking 3.0也就废弃了NSURLConnection相关的AFURLConnectionOperation，AFHTTPRequestOperation，AFHTTPRequestOperationManager三个类，并且建议使用AFHTTPSessionManager，所以YiBaseRequest也是基于AFHTTPSessionManager的封装。

YiNetwork目前依赖JSONModel version1.1.2和AFNetworking version2.6.1，是一套值得选择的App请求方案。

#### Podfile

```ruby
platform :ios, '7.0'
pod "YiNetwork", "~> 0.9.2"
```

####YiBaseModel
YiBaseModel继承自第三方库JSONModel，当然你也可以不用使用它，自己解析JSON数据或者其它格式的数据
####YiBaseRequest
YiBaseRequest必须子类化
#####属性
<pre>
@property (nonatomic, strong) NSMutableDictionary *getParams;
@property (nonatomic, strong) NSMutableDictionary *postParams;
</pre>
可以在子类自定义的init方法里面，加入需要的GET参数或者POST参数


<pre>
@property (nonatomic, assign) NSInteger retryCount;
@property (nonatomic, assign) NSInteger retryIndex;
</pre>
retryCount表示请求出错时重试的次数，默认为0；retryIndex表示正在重试第几次



#####方法
<pre>
- (void)requestWithSuccess:(void(^)(YiBaseModel *model,NSURLSessionTask *task))success
                   failure:(void(^)(NSError *error,NSURLSessionTask *task))failure;
</pre>
数据请求的方法，只要在上层调用该方法就可以获得请求成功或者失败的反馈，以得到YiBaseModel的数据。

<pre>
- (YiHTTPRequestMethod)requestMethod;

</pre>
需要实现的子类方法，表示请求方法，默认是YiHTTPRequestMethodGet为GET请求
<pre>
- (YiBaseModel *)responseModelWithData:(id)data;

</pre>
处理请求到得数据



<pre>
- (NSString *)pathName;
- (NSString *)rootUrl;
</pre>
pathName表示请求的具体URL路径；rootUrl表示请求的URL


<pre>
- (AFConstructingBlock)constructingBodyBlock;

</pre>
当需要上传文件时可以使用

<pre>
- (void)cancel;
</pre>
取消当前的NSURLSessionTask对象，也就是取消这次请求

#####发送一个GET请求
只要分别子类化YiBaseRequest和YiBaseModel，在上层使用就非常简单

<pre>
//通过GET请求获取用户信息
    YiGetUserInfoRequest *getUserInfoRequest=[[YiGetUserInfoRequest alloc] init];
    [getUserInfoRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
        
        NSLog(@"username is %@",((YiUserInfoModel *)model).name);
        
    } failure:^(NSError *error,NSURLSessionTask *task){
        
    }];
</pre>

子类化YiBaseModel为YiUserInfoModel
<pre>
@interface YiUserInfoModel : YiBaseModel
@property(nonatomic,strong) NSString<Optional> *name;
@end
</pre>

子类化YiBaseRequest为YiGetUserInfoRequest
<pre>

@implementation YiGetUserInfoRequest
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithNameId:(NSString *)nameId {
    self = [super init];
    if (self) {
        
        [self.getParams setValue:nameId forKey:@"name_id"];
        
    }
    return self;
}
- (NSString *)pathName
{
    return @"users/coderyi";
}
- (YiHTTPRequestMethod)requestMethod
{
    return YiHTTPRequestMethodGet;
}
- (YiBaseModel *)responseModelWithData:(id)data
{
    
    return [[YiUserInfoModel alloc] initWithDictionary:data error:nil];
}
@end

</pre>



#####发送一个POST请求
<pre>
//通过POST请求修改用户信息
    YiModifyUserInfoRequest *modifyUserInfoRequest=[[YiModifyUserInfoRequest alloc] initWithNameId:@"coderyi"];
    [modifyUserInfoRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
        
        NSLog(@"username is %@",((YiUserInfoModel *)model).name);
        
    } failure:^(NSError *error,NSURLSessionTask *task){
        
    }];
</pre>
子类化YiBaseRequest为YiModifyUserInfoRequest
<pre>

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
</pre>




#####上传图片
<pre>
 //上传一张图片
        UIImage *image;
        YiUploadImageRequest *uploadImageRequest=[[YiUploadImageRequest alloc] initWithImage:image];
        [uploadImageRequest requestWithSuccess:^(YiBaseModel *model,NSURLSessionTask *task){
            NSLog(@"model is %@",model);
    
        } failure:^(NSError *error,NSURLSessionTask *task){
            
        }];
</pre>
子类化YiBaseRequest为YiUploadImageRequest
<pre>
@implementation YiUploadImageRequest{
    UIImage *_image;
}


- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}
- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"image";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}
@end
</pre>