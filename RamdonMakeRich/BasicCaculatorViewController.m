//
//  BasicCaculatorViewController.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/1.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "BasicCaculatorViewController.h"
#import "TAVDatabaseTool.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface BasicCaculatorViewController ()

@property (nonatomic, strong) UIButton *caculatorBtn;
@property (nonatomic, strong) TAVDatabaseTool *database;


@end

@implementation BasicCaculatorViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TAVDatabaseTool *databaseTool = [TAVDatabaseTool share];
    self.database = databaseTool;
    [self customerView];
}

- (void)customerView {
    self.caculatorBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 66, 44)];
    [self.caculatorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.caculatorBtn setBackgroundColor:[UIColor redColor]];
    [[self.caculatorBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self readBallData];
    }];
    [self.view addSubview:self.caculatorBtn];
}

- (void)readBallData {
    
}

@end
