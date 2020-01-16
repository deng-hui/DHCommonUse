//
//  DHClassList.h
//  DH_CommonUse-iOS13.2
//
//  Created by wangdenghui on 2020/1/7.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DHClassList : NSObject
+ (NSDictionary *)getClassMethodList:(Class)class;

+ (NSDictionary *)getClassPropertyList:(Class)class;

+ (NSDictionary *)getClassIvarList:(Class)class;



+ (NSArray *)getClassProtocolList:(Class)class;

@end

NS_ASSUME_NONNULL_END
