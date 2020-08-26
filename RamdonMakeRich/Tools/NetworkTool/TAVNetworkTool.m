//
//  NetworkTool.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/3.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVNetworkTool.h"
#import "TAVHallModel.h"

static NSString *AppCode = @"5ca6cbf36a9d45a78a2fc4b071f2333e";
static NSString *AppKey = @"ea0b39f148043dc1cb58fb857b17097f";
static NSString *Host = @"https://jisucpkj.market.alicloudapi.com";

@interface TAVNetworkTool()

@property (nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation TAVNetworkTool
static TAVNetworkTool *networkTool;

+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkTool = [[self alloc]init];
    });
    return networkTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkTool = [super allocWithZone:zone];
    });
    return networkTool;
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return [TAVNetworkTool share];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [TAVNetworkTool share];
}

- (void)resetParams:(NSDictionary *)dic {
    NSString *issuenoStr = dic[@"issueno"];
    int limit = [dic[@"limit"] intValue];
    [self requestLotteryHistory:issuenoStr andLimit:limit withResultBlock:^(id _Nonnull dic) {
        
    }];
}

- (void)requestLotteryHistory:(id _Nullable)issueno andLimit:(int)limit withResultBlock:(nonnull void (^)(id _Nonnull))resultBlock {
    NSString *path = @"/caipiao/history";
    NSString *method = @"POST";

    NSString *querys = [NSString stringWithFormat:@"?caipiaoid=11&issueno=%@&num=%d", issueno == nil ? @"" : issueno, limit];//@"?caipiaoid=11&issueno=&num=20";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  Host,  path , querys];
    NSString *bodys = @"null";

    self.request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy:1 timeoutInterval: 5];
    self.request.HTTPMethod = method;
    [self.request addValue:  [NSString  stringWithFormat:@"APPCODE %@", AppCode] forHTTPHeaderField: @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [self.request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [self.request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:self.request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
//            self.lotteryDic = [self createErrorMsg:error.description];
            resultBlock([self createErrorMsg:error.description]);
            return;
        }
        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
        
        NSError *jsonError;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:&jsonError];
        
        if (jsonError == nil) {
            
            resultBlock([self createMsg:dic[@"result"]]);
        } else {
            resultBlock([self createErrorMsg:@"error"]);
        }
        
        //打印应答中的body
        NSLog(@"Response body: %@" , bodyString);
        }];

    [task resume];
}

- (NSDictionary *)createErrorMsg:(NSString *)msg {
    NSDictionary *errorDic = @{@"status": @(-1), @"msg": msg};
    return errorDic;
}

- (NSDictionary *)createMsg:(id)data {
    NSDictionary *errorDic = @{@"status": @(0), @"msg": @"without error", @"data": data};
    return errorDic;
}
@end
