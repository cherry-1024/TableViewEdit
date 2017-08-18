//
//  FriendModel.h
//  TableViewEdit
//
//  Created by csdc on 2017/8/18.
//  Copyright © 2017年 csdc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *message;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
