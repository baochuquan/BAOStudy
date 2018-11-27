//
//  BAORuntimeVarViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/11/20.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BAORuntimeVarViewController.h"
#import "BAORuntimeVarModel.h"
#import <objc/runtime.h>

// 成员变量
// Ivar: 实例变量类型，是一个指向objc_ivar结构体的指针
// typedef struct objc_ivar *Ivar;

// 属性
// objc_property_t：声明的属性的类型，是一个指向objc_property结构体的指针
// typedef struct objc_property *objc_property_t;
// class_copyPropertyList：获取所有属性，但并不会获取无@property声明的成员变量
// property_getName: 获取属性名
// property_getAttributes: 获取属性特性描述字符串，返回objc_property_attribute_t结构体列表
//      属性类型  name值：T  value：变化
//      编码类型  name值：C(copy) &(strong) W(weak) 空(assign) 等 value：无
//      非/原子性 name值：空(atomic) N(Nonatomic)  value：无
//      变量名称  name值：V  value：变化
// property_copyAttributeList: 获取属性的所有特性
//      使用property_getAttributes获得的描述是property_copyAttributeList能获取到的所有的name和value的总体描述，如 T@"NSDictionary",C,N,V_dict1

@interface BAORuntimeVarViewController ()

@property (nonatomic, strong) BAORuntimeVarModel *model;

@end

@implementation BAORuntimeVarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupValue];
    // Test: 获取成员变量
    [self getInstanceVars];
    // Test: 更新私有成员变量
    [self updatePrivateVar];
    // Test: 获取属性及其特征
    [self getProperties];
}

- (void)setupValue {
    self.model = [[BAORuntimeVarModel alloc] init];
}

- (void)getInstanceVars {
    unsigned int count = 0;

    Ivar *ivars = class_copyIvarList([BAORuntimeVarModel class], &count);   // 获取所有成员变量
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);                              // 获取成员变量名
        const char *type = ivar_getTypeEncoding(ivar);                      // 获取成员变量类型编码
        NSLog(@"%s 的类型是 %s", name, type);
    }
    free(ivars);
}

- (void)updatePrivateVar {
    Ivar ivar = class_getInstanceVariable([BAORuntimeVarModel class], "_insStr1");  // 获取指定名称的成员变量
    const char *name = ivar_getName(ivar);
    NSString *before = object_getIvar(self.model, ivar);                            // 获取某个对象指定成员变量的值
    object_setIvar(self.model, ivar, @"newValue");                                  // 设置某个对象指定成员变量的值
    NSString *after = object_getIvar(self.model, ivar);
    NSLog(@"%s 的值从 %@ 更新为 %@", name, before, after);
}

- (void)getProperties {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([BAORuntimeVarModel class], &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);                  // 属性名
        const char *propertyAttr = property_getAttributes(property);    // 属性描述
        NSLog(@"%s 的属性描述是 %s", name, propertyAttr);

        // 属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int j = 0; j < attrCount; j++) {
            objc_property_attribute_t attr = attrs[j];
            const char *name = attr.name;
            const char *value = attr.value;
            NSLog(@"    属性描述 %s 的值为 %s", name, value);
        }
        free(attrs);
        NSLog(@"\n");
    }
    free(properties);
}

// JSON 转换为 Model
// 原理：利用 runtime 提供的函数遍历 Model 自身所有属性，如果属性在 JSON 中有对应的值，则将其赋值。

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self) {
        // (1) 获取类的属性及属性对应的类型
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *atts = [NSMutableArray array];

        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            // 通过 property_getName 函数获得属性的名字
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];  
            // 通过 property_getAttributes 函数获得属性的名字和 @encode 编码
            NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [atts addObject:propertyAttribute];
        }
        free(properties);

        // (2) 根据类型给属性赋值
        for (NSString *key in keys) {
            if ([dict valueForKey:key] != nil) {
                [self setValue:[dict valueForKey:key] forKey:key];
            }
        }
    }
    return self;
}

@end
