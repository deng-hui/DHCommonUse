//
//  DHStringViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/23.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHStringViewController.h"

@interface DHStringViewController ()

@end

@implementation DHStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = @[@"", @"Y", @"Yi", @"Yic", @"Yicy", @"Yicye", @"abcdefhg", @"我", @"我们", @"我爱你", @"我爱你们", @"奥东方季道"];
    [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index:%ld :%@ -> %@", idx, obj, [DHStringViewController secretStringWithString:obj]);

    }];
    
    [self getLaunchTime];

}

-(NSString*)getLaunchTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得当前系统的时区
//
//    [dateFormatter setTimeZone:zone];// 设定时区
//
    // YYYY 获取的年不准
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    NSLog(@"time:%@", currentDateStr);
    return currentDateStr;
}

/**
 一个汉字和一个英文字符都只算一个字符
 通用规则：显示前3位和最后1位明文，其它用*号显示；长度不足时保证第1位和是后1位可见。比如Yicye001,脱敏后应该显示Yic****1
 长度=1，不隐藏；比如Y,脱敏后应该显示Y
 长度=2，*第2位；比如Yi,脱敏后应该显示Y****
 长度=3，*第2位；比如Yic,脱敏后应该显示Y****c
 长度=4，*第3位；比如Yicy,脱敏后应该显示Yi****c
 长度》=5，*第3位-倒数第2位；比如Yicye,脱敏后应该显示Yic****e；Yicye0,脱敏后应该显示Yic****0
 1 - 1
 2 - 1
 3 - 1
 4 - 2
 5 - 3
 6 - 3
 */
+ (NSString *)secretStringWithString:(NSString *)string  {
    NSInteger len = string.length;
    if (len <= 1) {
        return string;
    }
    NSInteger toIndex = 3;
    NSInteger fromIndex = len - 1;
    if (len == 2) {
        toIndex = 1;
        fromIndex = len;
    }
    else if (len < 5) {
        toIndex -= 2;
    }
    NSString *prefix = [string substringToIndex:toIndex];
    NSString *suffix = [string substringFromIndex:fromIndex];
    NSString *secret = [NSString stringWithFormat:@"%@****%@", prefix, suffix];
    return secret;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
