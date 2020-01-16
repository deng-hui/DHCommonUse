//
//  DHRegularViewController.m
//  Example
//
//  Created by wangdenghui on 2020/1/6.
//  Copyright © 2020 王登辉. All rights reserved.
//

#import "DHRegularViewController.h"
#import "DHClassList.h"

// 匹配
#define REGULAREXPRESSION_OPTION(regularExpression, regex, option)                                                               \
\
static inline NSRegularExpression *Function##regularExpression()                                                                    \
{                                                                                                                            \
static NSRegularExpression *_##regularExpression = nil;                                                                  \
static dispatch_once_t onceToken;                                                                                        \
dispatch_once(&onceToken, ^{                                                                                             \
_##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];             \
});                                                                                                                      \
\
return _##regularExpression;                                                                                             \
}

#define REGULAREXPRESSION(regularExpression, regex)                                                                              \
REGULAREXPRESSION_OPTION(regularExpression, regex, NSRegularExpressionCaseInsensitive)

// 老的鲨鱼表情
static NSString * const kOldSharkEmojiRegular = @"\\[emot:[a-zA-Z0-9]{5}\\]";
// 新的联盟表情
static NSString * const kEmojiRegular = @"\\[[a-zA-Z0-9\u4e00-\u9fa5]{1,5}\\]";
// 所有的表情包含新旧
static NSString * const kAllSlashEmojiRegular = @"\\[([a-zA-Z0-9\u4e00-\u9fa5]{1,5}|emot:[a-zA-Z0-9]{5})\\]";
// 过滤表情（对于老的表情过滤时不做严格匹配）
static NSString * const kAllEmojiFilteredRegular = @"\\[([a-zA-Z0-9\u4e00-\u9fa5]{1,5}|emot:[a-zA-Z0-9]+)\\]";

static NSString * const kTestFilteredRegular = @"凡人皆有一死";

REGULAREXPRESSION(OldSharkEmojiRegularExpression, kOldSharkEmojiRegular)
REGULAREXPRESSION(EmojiRegularExpression, kEmojiRegular)
REGULAREXPRESSION(AllSlashEmojiRegularExpression, kAllSlashEmojiRegular)

REGULAREXPRESSION(TestRegularExpression, kTestFilteredRegular)
REGULAREXPRESSION(PatternRegularExpression, @"(凡人?:皆有一死)");


@interface DHRegularViewController (){
    NSString *content;
}
@end

@implementation DHRegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    CFTimeInterval startTime = CACurrentMediaTime();
    NSString *file = [[NSBundle mainBundle] pathForResource:@"【全本校对】《冰与火之歌全集》作者：乔治 R·R·马丁" ofType:@"txt"];
    content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
//    content = @"‘你为此人之死献出了一切，但奴隶除了生命一无所有。神想要你的生命，你的余生都必须侍奉神。’从那以后，我们就有了两个人。”他的手温柔而坚定地抓住她的胳膊，“凡人皆有一死。我们是死亡的工具，并非死亡本身。你取歌手性命，乃是擅行神职。我们杀人，但无权作评判。你懂吗？”";
    CFTimeInterval endTime = CACurrentMediaTime();
    CFTimeInterval consumingTime = endTime - startTime;
    NSLog(@"耗时：%@ ms", @(consumingTime * 1000));
    
//    [self testMatchTime];
    
    [self pattern];
}


/**
单行： 手动 0.036ms
      regular:0.021ms
小说： 手动 140.91 ms
      regular:8.34 ms
*/
- (void)testMatchTime {
    CFTimeInterval startTime2 = CACurrentMediaTime();
//    [self regular:content];
    [self manual:content];
    CFTimeInterval endTime2 = CACurrentMediaTime();
    CFTimeInterval consumingTime2 = endTime2 - startTime2;
    NSLog(@"matches耗时：%@ ms", @(consumingTime2 * 1000));
    
    NSDictionary *list = [DHClassList getClassIvarList:[NSRegularExpression class]];
    NSArray *protocolList = [DHClassList getClassProtocolList:[NSRegularExpression class]];
    NSLog(@"list:%@", list.allKeys);
    NSLog(@"protocolList:%@", protocolList);

//    NSLog(@"\n------\n results-count:%ld\n array:%@\n-------\n", resutls.count, resutls);

}


- (void)pattern {
    
    /**
     typedef NS_OPTIONS(NSUInteger, NSMatchingOptions) {
        NSMatchingReportProgress         = 1 << 0, //找到最长的匹配字符串后调用block回调
        NSMatchingReportCompletion       = 1 << 1, //找到任何一个匹配串后都回调一次block
        NSMatchingAnchored               = 1 << 2, //从匹配范围的开始出进行极限匹配
        NSMatchingWithTransparentBounds  = 1 << 3, //允许匹配的范围超出设置的范围
        NSMatchingWithoutAnchoringBounds = 1 << 4  //禁止^和$自动匹配行还是和结束
     };
     
     typedef NS_OPTIONS(NSUInteger, NSMatchingFlags) {
        NSMatchingProgress               = 1 << 0, //匹配到最长串是被设置
        NSMatchingCompleted              = 1 << 1, //全部分配完成后被设置
        NSMatchingHitEnd                 = 1 << 2, //匹配到设置范围的末尾时被设置
        NSMatchingRequiredEnd            = 1 << 3, //当前匹配到的字符串在匹配范围的末尾时被设置
        NSMatchingInternalError          = 1 << 4  //由于错误导致的匹配失败时被设置
     };
     */
    
    NSMatchingOptions options = NSMatchingReportProgress | NSMatchingReportCompletion | NSMatchingAnchored | NSMatchingWithTransparentBounds | NSMatchingWithoutAnchoringBounds;
    
    NSArray<NSTextCheckingResult *> *results = [FunctionPatternRegularExpression() matchesInString:content options:options range:NSMakeRange(0, [content length])];

    NSLog(@"\n------\n results-count:%ld\n array:%@\n-------\n", results.count, results);
}

- (void)manual:(NSString *)content {
    [self getRangeStr:content findText:@"凡人皆有一死"];
}

- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
    
    if (findText == nil || [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
//        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {
                
                //去掉这个abc字符串
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else {
                //添加符合条件的location进数组
                
//                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            }
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}

- (void)regular:(NSString *)content {
    NSArray *resutls = [self matches:FunctionTestRegularExpression() content:content];
}

- (NSArray<NSString *> *)matches:(NSRegularExpression *)expression content:(NSString *)content
{
    if (!content || ![content isKindOfClass:[NSString class]]) {
        return nil;
    }

    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];

    NSArray<NSTextCheckingResult *> *results = [expression matchesInString:content options:NSMatchingWithTransparentBounds range:NSMakeRange(0, [content length])];
    for (NSTextCheckingResult *result in results) {
        NSRange range = result.range;
        NSString *subStr = [content substringWithRange:range];
        [dataArray addObject:subStr];
    }
    return dataArray;
}
    
@end
