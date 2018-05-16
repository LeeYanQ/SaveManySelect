//
//  PeopleModel.h
//  LBDemo
//
//  Created by 训网高 on 2018/4/24.
//  Copyright © 2018年 训网高. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface PeopleModel : NSObject <NSCoding>
@interface PeopleModel : NSObject
@property (nonatomic, copy) NSString *name;     //姓名
@property (nonatomic, copy) NSString *age;      //年龄
@property (nonatomic, copy) NSString *gender;   //性别
@end
