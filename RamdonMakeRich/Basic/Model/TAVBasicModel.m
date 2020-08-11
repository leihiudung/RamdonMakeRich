//
//  TAVModel.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVBasicModel.h"
#import <objc/runtime.h>

@implementation TAVBasicModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];

    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

/// 对象转字典
/// @param model 对象模型
- (NSDictionary *)parseModelInDictionary:(TAVBasicModel *)model {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *props = class_copyPropertyList([model class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String: property_getName(prop)];
        id propValue = [model valueForKey:propName];
        
        if (propValue == nil) {
            dic[propName] = [NSNull null];
        } else {
            dic[propName] = propValue;
        }
    }
    return dic.copy;
}

@end
