//
//  FriendModel.m
//  TableViewEdit
//
//  Created by csdc on 2017/8/18.
//  Copyright © 2017年 csdc. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    FriendModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
