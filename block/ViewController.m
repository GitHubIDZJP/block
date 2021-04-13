//
//  ViewController.m
//  block
//
//  Created by 邹俊平 on 2020/8/27.
//  Copyright © 2020 邹俊平. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
typedef void(^AutoBlock)(id obj);//1类型定义一个block
@property(nonatomic,copy)AutoBlock blk;//2
@property(nonatomic,copy)NSMutableArray *analysisArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //使用
//    self.myBlockOne = ^int(a,b){
//
//    }
    
    
    self.analysisArr = [NSMutableArray array];
    ViewController *__weak temp = self;
    self.blk = ^(id obj){
        [self.analysisArr addObject:obj];
        NSLog(@"array count = %ld",[self.analysisArr count]);
    };
    
   
    
    
    
    void (^testBlock)(void) = ^(){
        NSLog(@"调用了block");
    };
    testBlock();
    NSMutableArray *array = [NSMutableArray array];
    void(^Block)(void)=^{
        [array arrayByAddingObject:@"123"];//// 不需要加上上__block,因为不是重新赋值
        
    };
    Block;
    NSLog(@"调用了:%@",Block);
    
    //需要加__block ，重新赋值操作
    __block NSMutableArray *newArr = nil;
    void (^newBlock)(void) = ^{
        newArr = [NSMutableArray array];
    };
    
    NSLog(@"newBlock：%@",newBlock);
    
    //block内存管理
    /*
    {
     copy后
     全局  ： 什么也不做
     堆区 ：增加引用计数
     栈区： 栈
      }
    */
    //NSLog(@"");
    //全局block，block没有捕获外部的便利，此时对NSGlobalBlock的retain、copy、release操作都无效，MRC和ARC都一样
    void (^MyBlock) (int  x);
    MyBlock = ^(int number){
        int result = number + 2;
        NSLog(@"结果:%d",result);
    };
    MyBlock(10);
    // 栈区：默认strong，block会捕获外部变量，实际： 栈区到堆区的过程会有，把栈区的block迁移到堆区，使用了__weak或者__unsafe__unretained的修饰符，那么系统就不会为我们做copy的操作，不会将其迁移到堆区
    
//   __weak void (^ kjBlock) (int kj) = ^(int num){
//        int sbResult  = num +  kj;
//         NSLog(@"结果:%d",sbResult);
//    };
    
    //block循环引用，很致命，会造成内存泄露，也可以理解为对象强引用，而block又持有这个对象，这样就会产生循环引用
// 解决办法： 给block的持有对象属性进行一个弱引用，也就是给对象属性加一个__weak
}


@end
