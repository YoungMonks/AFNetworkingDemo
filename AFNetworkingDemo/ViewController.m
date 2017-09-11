//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by 张江威 on 2017/8/14.
//  Copyright © 2017年 YoungMonk. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "MJExtension.h"
#import "YMModel.h"

@interface ViewController ()

@property (strong, nonatomic)AFHTTPSessionManager * manger;
@property (strong, nonatomic) YMModel * mode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manger = [AFHTTPSessionManager manager];
    self.manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
}

- (IBAction)AFNetBtn:(id)sender {
    
    NSDictionary * dic = @{@"requestType":@"1",
                           @"borrow_type":@"all",
                           @"start":[NSString stringWithFormat:@"%ld",(long)1]
                           };
    [self.manger POST:@"http://m.lichengdai.com/webapp/Threezeroinvest/index?" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功的
        NSDictionary * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *arr1 = [[NSArray alloc]initWithArray:[YMModel mj_objectArrayWithKeyValuesArray:arr[@"data"]]];
        _mode = [arr1 objectAtIndex:0];
        
        NSLog(@"%@",_mode.borrow_name);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败的
        NSLog(@"请求失败");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
