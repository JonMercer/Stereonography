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
  
  
  /*
   // grab the image from the references
   // NSString *string = [[NSBundle mainBundle] pathForResource:@"Steg_l" ofType:@"JPG"];
   UIImage *image = [UIImage imageNamed:@"Untitled-2.jpg"];
   
   NSData * data = UIImagePNGRepresentation(image);
   
   unsigned char *byteArray = (unsigned char*)data.bytes;
   
   NSUInteger arrayLength = data.length;
   
   NSString *string = @"";
   
   // print first few bytes
   for(unsigned int i = 0 ; i < arrayLength; i++) {
   //byteArray[i] = byteArray[i] & 0xFD;
   
   unsigned int val = (byteArray[i] << 24 | byteArray[i+1] << 16 | byteArray[i+2] << 8| byteArray[i+3]);
   
   // string = [[NSString alloc]initWithFormat:@"%@%x",string,val];
   
   if (val == 0x49484452){
   NSLog(@"IHDR: %x",val);
   }else if (val == 0x49444154){
   
   string = @"";
   for (int j = i+5; j < i+50; j++) {
   string = [[NSString alloc]initWithFormat:@"%@ %x",string,byteArray[j]];
   }
   NSLog(@"%@",string);
   
   
   NSLog(@"");
   }else if (val == 0x49454E44){
   NSLog(@"IEND: %x",val);
   }else if (val == 0x504C5445){
   NSLog(@"PLTE: %x",val);
   }
   
   
   
   //NSLog(@"%x",val);
   
   }
   //NSLog(@"%@",string);
   
   // byteArray[2009] = 0xFF;
   NSData *data2 = [NSData dataWithBytes:byteArray length:arrayLength];
   
   CGDataProviderRef imgProvider = CGDataProviderCreateWithCFData((CFDataRef) data2);
   CGImageRef imgRef = CGImageCreateWithPNGDataProvider(imgProvider, NULL, true, kCGRenderingIntentDefault);
   
   CGImageSourceRef source = CGImageSourceCreateWithData( (CFDataRef) data2, NULL);
   NSDictionary* metadata = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
   
   NSLog(@"%@",metadata);
   
   UIImage *outputImage = [UIImage imageWithCGImage:imgRef];
   UIImage *jpegImage = [UIImage imageNamed:@"Steg_l.JPG"];
   [self displayImageAt:25 image:jpegImage];
   [self displayImageAt:25+300+25 image:outputImage];
   
   */
  
  
  /*
   *
   */
  UIImage *jpegImage = [UIImage imageNamed:@"IMG_1086.JPG"];
  
  NSData *bitmapFileData = [jpegImage bitmapDataWithFileHeader];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image666.BMP"];
  
  // Save image.
  [bitmapFileData writeToFile:filePath atomically:YES];
  
  NSData *loadedBMP = [[NSData alloc]initWithContentsOfFile:filePath];
  
  
  UIImage *bmpImage = [[UIImage alloc ] initWithData:loadedBMP];
  UIImageWriteToSavedPhotosAlbum(bmpImage, nil, nil, nil);
//  bitmapFileData.bytes;
  
  // get the CGImageref
  CGImageRef imageRef = jpegImage.CGImage;
  
  // get a copy of the data
  // NSData *data = CFBridgingRelease(CGDataProviderCopyData(provider));      // get copy of the data
  
  // grab some useful data form the image
  NSInteger       bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
  NSInteger       bitsPerPixel     = CGImageGetBitsPerPixel(imageRef);
  CGBitmapInfo    bitmapInfo       = CGImageGetBitmapInfo(imageRef);
  NSInteger       bytesPerRow      = CGImageGetBytesPerRow(imageRef);
  NSInteger       width            = CGImageGetWidth(imageRef);
  NSInteger       height           = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorspace       = CGImageGetColorSpace(imageRef);
  
  // allocate memory for c array of pixel data
  UInt32 *inputPixels = (UInt32*) calloc(width * height,sizeof(UInt32));
  
  
  CGContextRef context = CGBitmapContextCreate(inputPixels, width, height,
                                               bitsPerComponent, bytesPerRow, colorspace,
                                               bitmapInfo);
  
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  
  for (NSUInteger j = 0; j < height; j++) {
    for (NSUInteger i = 0; i < width; i++) {
      
      UInt32 * pixel = inputPixels + (j * width) + i;
      UInt32 color = *pixel;
      UInt32 averageColor = (R(color) + G(color) + B(color)) / 3.0;
      
      
      *pixel = RGBAMake(averageColor, averageColor, averageColor, A(color));
      
      //NSLog(@"after %u",*pixel);
      
    }
  }
  
  
  
  // [self doSomething:outputBuffer];
  
  CGDataProviderRef outputProvider = CGDataProviderCreateWithData(NULL, inputPixels, sizeof(inputPixels), releaseData);
  
  CGImageRef outputImageRef = CGBitmapContextCreateImage(context);
  
  UIImage *outputImage = [UIImage imageWithCGImage:outputImageRef];
  
  [self displayImageAt:25 image:jpegImage];
  [self displayImageAt:25+300+25 image:outputImage];
  
  CGImageRelease(outputImageRef);
  CGDataProviderRelease(outputProvider);
  CGColorSpaceRelease(colorspace);
  CGContextRelease(context);
  
  
}
-(void)doSomething:(void*) data{
  
  
}
-(void)displayImageAt:(int)yposition image:(UIImage*)image{
  
  UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
  imageView.frame = CGRectMake(25, yposition, kScreenWidth - 50, 300);
  [self.view addSubview:imageView];
  
}
void releaseData(void *info, const void *data, size_t size)
{
  free((void *)data);
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
@end