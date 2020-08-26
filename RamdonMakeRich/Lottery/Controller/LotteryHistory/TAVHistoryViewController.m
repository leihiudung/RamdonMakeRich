

//
//  TAVHistoryViewController.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHistoryViewController.h"
#import "TAVHallViewModel.h"
#import "TAVLotteryPO.h"
#import "TAVHistoryView.h"
/**
 先到数据中查询最新10条记录,当存在就显示.不存在就向服务器加载
 */

@interface TAVHistoryViewController ()
@property (nonatomic, strong) TAVHistoryView *historyView;

@property (nonatomic, assign) BOOL loadMoreFlag;
@property (nonatomic, assign) BOOL requestMoreFlag;

@end

@implementation TAVHistoryViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _historyView = [[TAVHistoryView alloc]initWithFrame:self.view.frame andViewModel:self.viewModel];
    [self.view addSubview:_historyView];
    
    __weak typeof(self)weakSelf = self;
    [[[self.historyView rac_signalForSelector:@selector(scrollViewDidScroll:) fromProtocol:@protocol(UITableViewDelegate)] skip:1] subscribeNext:^(RACTuple * _Nullable x) {
        
        UITableView *tableView = x.first;
         CGFloat currentOffsetY = tableView.contentOffset.y;
        if (currentOffsetY + tableView.frame.size.height > tableView.contentSize.height + 45 && !self.loadMoreFlag) {
            self.loadMoreFlag = YES;
            
            NSDictionary *dic = @{@"from_issueno": [NSString stringWithFormat:@"%d", [((TAVLotteryPO *)[(TAVHallViewModel *)self.viewModel lotteryHistoryArr].lastObject).issue intValue] - 1], @"limit": @20};
            [[((TAVHallViewModel *)self.viewModel).queryLotteryHistoryCommand execute:dic] subscribeNext:^(id  _Nullable x) {
                NSArray *arr = x;
                if (arr.count == 0) {
                    NSDictionary *dic = @{@"from_issueno": ((TAVLotteryPO *)[(TAVHallViewModel *)self.viewModel lotteryHistoryArr].lastObject).issue, @"limit": @20};
                    [weakSelf requestLottery:dic];
                    return;
                }
            } completed:^{
                self.loadMoreFlag = NO;
            }];

        }
        
        if (currentOffsetY < (self.navigationController.navigationBar.frame.size.height * 2 + 45) * -1) {
            self.requestMoreFlag = YES;
        }
         
    }];
    
    [[self.historyView rac_signalForSelector:@selector(scrollViewDidEndDragging:willDecelerate:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        if (self.requestMoreFlag) {
            
            int diffissueno = [self calucatorDiffIssue:[((TAVHallViewModel *)self.viewModel).lotteryHistoryArr[0] lottery_time]];
            if (diffissueno == 0) {
                return;
            }
            
            UITableView *tableView = x.first;
            UIEdgeInsets edgeInset = tableView.contentInset;
            edgeInset.top = 45;
            tableView.contentInset = edgeInset;
            
            [weakSelf requestLottery:@{@"limit": @(diffissueno)}];
        }
        
    }];
    [self.historyView.tableView setDelegate:self.historyView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"limit": @20};
    __weak typeof(self)weakSelf = self;
    [[((TAVHallViewModel *)self.viewModel).queryLotteryHistoryCommand execute:dic] subscribeNext:^(id  _Nullable x) {
        NSArray *arr = x;
        if (arr.count == 0) {
            [weakSelf requestLottery:dic];
            return;
        }
        
    }];
    
}


- (void)requestLottery:(NSDictionary *)paramDic {
    __weak typeof(self)weakSelf = self;
    [[[(TAVHallViewModel *)self.viewModel requestLotteryHistoryCommand] execute:paramDic] subscribeNext:^(id  _Nullable x) {
       NSDictionary *dic = (NSDictionary *)x;
       if ([dic[@"state"] integerValue] == 0) {
           // dic[@"data"]返回的是数组, 
//           int diffissueno = [self calucatorDiffIssue:[((TAVHallViewModel *)self.viewModel).lotteryHistoryArr[0] lottery_time]];
//           if (diffissueno == 0) {
//               return;
//           }
           
           UITableView *tableView = self.historyView.tableView;
           UIEdgeInsets edgeInset = tableView.contentInset;
           edgeInset.top = 0;
           tableView.contentInset = edgeInset;
           
           return;
       }

    } error:^(NSError * _Nullable error) {
       
    } completed:^{
        
    }];
}

/// 获取今天是星期几
- (int)calucatorDiffIssue:(NSString *)lastDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//    NSDate *date = [NSDate date];
//    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [dateFormatter dateFromString:lastDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:endDate toDate:[NSDate date]];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    
    // 业务代码
    int periodTime = days / 7;
    int residueDay = days % 7;
    
    int diffIssueno = 0;
    if (week == 7) {
        diffIssueno = periodTime * 3 + residueDay / 3;
    } else {
        BOOL isOccuor = [self getCustomDateWithHour:20];
        if (isOccuor) {
            diffIssueno = periodTime * 3 + residueDay / 3 + 1;
        } else {
            diffIssueno = periodTime * 3 + residueDay / 3;
        }
    }
    return diffIssueno;
}

// 计算2个日期相差天数
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
         （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
           对于时分 没有进行计算 可以忽略不计
        return days;
    }
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

//
- (BOOL)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间

    NSDate *currentDate = [NSDate date]; // 获得时间对象

    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区

    NSTimeInterval time = [zone secondsFromGMTForDate:currentDate];// 以秒为单位返回当前时间与系统格林尼治时间的差

    NSDate *dateNow = [currentDate dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    

    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *currentComps = [[NSDateComponents alloc] init];

    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];

//    //设置当天的某个点
//    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
//
//    [resultComps setYear:[currentComps year]];
//
//    [resultComps setMonth:[currentComps month]];
//
//    [resultComps setDay:[currentComps day]];
//
//    [resultComps setHour:[currentComps hour]];
//
//    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *resultCompoents = [resultCalendar components:unitFlags fromDate:dateNow];
//    return [resultCalendar dateFromComponents:resultComps];
    return currentComps.hour > 22;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

@end
