//
//  ViewController.h
//  block
//
//  Created by 邹俊平 on 2020/8/27.
//  Copyright © 2020 邹俊平. All rights reserved.
//

#import <UIKit/UIKit.h>
//block声明
typedef void (^Block)();
typedef int (^MyBlock)(int , int);
typedef void(^ConfirmBlock)(BOOL isOK);
typedef void(^AlertBlock)(NSInteger alertTag);
@interface ViewController : UIViewController

//定义属性
@property (nonatomic,copy) MyBlock myBlockOne;

@end

