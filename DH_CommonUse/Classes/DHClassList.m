//
//  DHClassList.m
//  DH_CommonUse-iOS13.2
//
//  Created by wangdenghui on 2020/1/7.
//

#import "DHClassList.h"
#import <objc/runtime.h>

@implementation DHClassList

+ (NSDictionary *)getClassMethodList:(Class)class {
    if (!class) {
        return nil;
    }
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(class, &methodCount);
    NSMutableDictionary *methodInfos = nil;
    if (methods) {
        methodInfos = [NSMutableDictionary new];
        for (unsigned int i = 0; i < methodCount; i++) {
            YYClassMethodInfo *info = [[YYClassMethodInfo alloc] initWithMethod:methods[i]];
            if (info.name) methodInfos[info.name] = info;
        }
        free(methods);
    }
    return [methodInfos copy];
}

+ (NSDictionary *)getClassPropertyList:(Class)class {
    if (!class) {
        return nil;
    }
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    NSMutableDictionary *propertyInfos = nil;
    if (properties) {
        propertyInfos = [NSMutableDictionary new];
        for (unsigned int i = 0; i < propertyCount; i++) {
            YYClassPropertyInfo *info = [[YYClassPropertyInfo alloc] initWithProperty:properties[i]];
            if (info.name) propertyInfos[info.name] = info;
        }
        free(properties);
    }
    return [propertyInfos copy];
}

+ (NSDictionary *)getClassIvarList:(Class)class {
    if (!class) {
        return nil;
    }
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(class, &ivarCount);
    NSMutableDictionary *ivarInfos = nil;
    if (ivars) {
        ivarInfos = [NSMutableDictionary new];
        for (unsigned int i = 0; i < ivarCount; i++) {
            YYClassIvarInfo *info = [[YYClassIvarInfo alloc] initWithIvar:ivars[i]];
            if (info.name) ivarInfos[info.name] = info;
        }
        free(ivars);
    }
    return [ivarInfos copy];
}

+ (NSArray *)getClassProtocolList:(Class)class {
    if (!class) {
        return nil;
    }
    unsigned int protocolCount = 0;
    Protocol * __unsafe_unretained _Nonnull *protocols = class_copyProtocolList(class, &protocolCount);
    
    NSMutableArray *protocolList = nil;
    if (protocols) {
        protocolList = [NSMutableArray new];
        for (unsigned int i = 0; i < protocolCount; i++) {
            Protocol *protocol = protocols[i];
            const char *n = protocol_getName(protocol);
            if (n) {
                NSString *name = [NSString stringWithUTF8String:n];
                [protocolList addObject:name];
            }
        }
        free(protocols);
    }
    return [protocolList copy];
}

@end
