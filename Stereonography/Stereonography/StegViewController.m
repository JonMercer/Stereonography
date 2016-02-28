//
//  StegViewController.m
//  dataModel
//
//  Created by omar abo baker on 2016-02-27.
//  Copyright © 2016 omar Abu-Baker. All rights reserved.
//

#import "StegViewController.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface StegViewController ()

@end

@implementation StegViewController

- (void)viewDidLoad {

   [super viewDidLoad];

   // grab the image from the references
   UIImage *jpegImage = [UIImage imageNamed:@"IMG_1086.JPG"];

   // create an nsdata jpeg representation of the image
   NSData *imageData = UIImageJPEGRepresentation(jpegImage, 1.0f);

   // display that image somewhere
   [self displayImageAt:25 image:jpegImage];

   // do something with that data
   [self doSomething:imageData];

   // convert that data back to JPEG
   UIImage *processedJpeg = [UIImage imageWithData:imageData];

   // display processed image somewhere
   [self displayImageAt:(25 + 300 + 25) image:processedJpeg];


}

-(void)doSomething:(NSData*) data{

   void* pointer;
   pointer = (__bridge void*)data;



}


-(void)displayImageAt:(int)yposition image:(UIImage*)image{

   UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
   imageView.frame = CGRectMake(25, yposition, kScreenWidth - 50, 300);
   [self.view addSubview:imageView];

}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
