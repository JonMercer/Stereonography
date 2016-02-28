//
//  StegViewController.m
//  dataModel
//
//  Created by omar abo baker on 2016-02-27.
//  Copyright © 2016 omar Abu-Baker. All rights reserved.
//
#import "StegViewController.h"
#import "UIImage+Test2.h"
@import ImageIO;
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
@interface StegViewController ()
@end
@implementation StegViewController
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  
 
  
  
}
-(void)doSomething:(void*) data{
  
  
}
-(void)displayImageAt:(int)yposition image:(UIImage*)image{
  
  UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
  imageView.frame = CGRectMake(25, yposition, kScreenWidth - 50, 300);
  [self.view addSubview:imageView];
  
}
//void releaseData(void *info, const void *data, size_t size)
//{
//  free((void *)data);
//}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
@end