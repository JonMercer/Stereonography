//
//  StegModel.m
//  Stereonography
//
//  Created by Odin on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

/*
 *
 *This file was created by Omar
 *
 */

#import "StegModel.h"
#import "UIImage+Test2.h"

#define max_question_length 100

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )


@implementation StegModel


-(NSString*) encryptWithQuestion:(NSString*)question  andAnswer:(NSString*)answer andMessage:(NSString*)message andImageKey:(NSString *)imageKey {
  
  NSData *bmpData = [[NSUserDefaults standardUserDefaults] objectForKey:imageKey];
  UIImage *image = [UIImage imageWithData:bmpData];
  
  // get the CGImageref
  CGImageRef imageRef = image.CGImage;
  
  // grab some useful data form the image
  NSInteger       bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
  //NSInteger       bitsPerPixel     = CGImageGetBitsPerPixel(imageRef);
  CGBitmapInfo    bitmapInfo       = CGImageGetBitmapInfo(imageRef);
  NSInteger       bytesPerRow      = CGImageGetBytesPerRow(imageRef);
  NSInteger       width            = CGImageGetWidth(imageRef);
  NSInteger       height           = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorspace       = CGImageGetColorSpace(imageRef);
  
  UInt32 *inputPixels = (UInt32*) calloc(width * height,sizeof(UInt32));
  
  CGContextRef context = CGBitmapContextCreate(inputPixels, width, height,
                                               bitsPerComponent, bytesPerRow, colorspace,
                                               bitmapInfo);
  
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  
  
  NSUInteger totalLength = [question length]+[answer length]+[message length]+4;
  unsigned char aBuffer[totalLength];
  NSString *myString = [[NSString alloc]initWithFormat:@"$%@~%@~%@^",question,answer,message];
  const char *utfString = [myString UTF8String];
  NSData *myData = [NSData dataWithBytes: utfString length: strlen(utfString)];
  
  [myData getBytes:aBuffer length:totalLength];
  
  // loop number of bytes times, writing 4 two bit values into seperate bytes each time
  int bytesWritten = 0;
  for (NSUInteger j = 0; j < height; j++) {
    for (NSUInteger i = 0; i < width; i++) {
      
      UInt32 * pixel = inputPixels + (j * width) + i;
      UInt32 color = (*pixel);
      
      if (bytesWritten == totalLength){
        break;
      }
      
      unsigned char byteToWrite = aBuffer[bytesWritten];
      unsigned char R = R(color);
      unsigned char G = G(color);
      unsigned char B = B(color);
      unsigned char A = A(color);
      unsigned char rreducedQualityDensity = R(color) & 0xFC;
      unsigned char greducedQualityDensity = G(color) & 0xFC;
      unsigned char breducedQualityDensity = B(color) & 0xFC;
      unsigned char areducedQualityDensity = A(color) & 0xFC;
      
      
      (*pixel) = RGBAMake(rreducedQualityDensity | ((byteToWrite >> (0)) & 0x03),
                          greducedQualityDensity | ((byteToWrite >> (2)) & 0x03),
                          breducedQualityDensity | ((byteToWrite >> (4)) & 0x03),
                          areducedQualityDensity | ((byteToWrite >> (6)) & 0x03));
      bytesWritten++;
      
      unsigned char rChar = R(*pixel) & 0x3;
      unsigned char gChar = G(*pixel) & 0x3;
      unsigned char bChar = B(*pixel) & 0x3;
      unsigned char aChar = A(*pixel) & 0x3;
      
      // concatenate the string bits to form a byte
      unsigned char newStringByte;
      newStringByte = (rChar << (0)) | (gChar << (2)) | (bChar << (4)) | (aChar << 6);
      NSLog(@"%c",newStringByte);
      
      
    }
    if (bytesWritten == totalLength){
      break;
    }
  }
  
  CGDataProviderRef outputProvider = CGDataProviderCreateWithData(NULL, inputPixels, sizeof(inputPixels), releaseData);
  
  CGImageRef outputImageRef = CGBitmapContextCreateImage(context);
  
  UIImage *outputImage = [UIImage imageWithCGImage:outputImageRef];
  
  NSData *bitmapFileData = [outputImage bitmapDataWithFileHeader];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"encrpted_Image.BMP"];
  
  // Save image.
  [bitmapFileData writeToFile:filePath atomically:YES];
  
  CGImageRelease(outputImageRef);
  CGDataProviderRelease(outputProvider);
  CGColorSpaceRelease(colorspace);
  CGContextRelease(context);
  
  return filePath;
  
}

-(NSString*) decryptImageQuestion: (NSString*)imageKey {
  
  NSData *bmpData = [[NSUserDefaults standardUserDefaults] objectForKey:imageKey];
  UIImage *image = [UIImage imageWithData:bmpData];
  
  // get the CGImageref
  CGImageRef imageRef = image.CGImage;
  
  // grab some useful data form the image
  NSInteger       bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
  //NSInteger       bitsPerPixel     = CGImageGetBitsPerPixel(imageRef);
  CGBitmapInfo    bitmapInfo       = CGImageGetBitmapInfo(imageRef);
  NSInteger       bytesPerRow      = CGImageGetBytesPerRow(imageRef);
  NSInteger       width            = CGImageGetWidth(imageRef);
  NSInteger       height           = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorspace       = CGImageGetColorSpace(imageRef);
  
  UInt32 *inputPixels = (UInt32*) calloc(width * height,sizeof(UInt32));
  
  CGContextRef context = CGBitmapContextCreate(inputPixels, width, height,
                                               bitsPerComponent, bytesPerRow, colorspace,
                                               bitmapInfo);
  
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  
  
  
  // NSUInteger totalLength = [question length]+[answer length]+[message length]+3;
  NSString *question = @"";
  
  // loop number of bytes times, writing 4 two bit values into seperate bytes each time
  for (NSUInteger j = 0; j < height; j++) {
    for (NSUInteger i = 0; i < width; i++) {
      
      UInt32 * pixel = inputPixels + (j * width) + i;
      UInt32 color = (*pixel);
      
      // grab the string bits
      unsigned char rChar = R(color) & 0x3;
      unsigned char gChar = G(color) & 0x3;
      unsigned char bChar = B(color) & 0x3;
      unsigned char aChar = A(color) & 0x3;
      
      // concatenate the string bits to form a byte
      unsigned char newStringByte = (rChar << (6)) | (gChar << (4)) | (bChar << (2)) | (aChar << 0);
      
      if (newStringByte == '~'){
        
        CGColorSpaceRelease(colorspace);
        CGContextRelease(context);
        
        return question;
      }
      
      if (i == 0 && j == 0 && newStringByte != '$'){
        return @"error could not find $ indicator, image may not contain message or your encryption method sucks ass";
      }
      
      if (newStringByte != '$')question = [[NSString alloc] initWithFormat:@"%@%c",question,newStringByte];
    }
  }
  
  return @"error";
}

-(NSString*) attemptToDecryptImageMessageWithAnswerKey: (NSString*)answer andImgKey:(NSString*)imageKey{
  
  
  NSData *bmpData = [[NSUserDefaults standardUserDefaults] objectForKey:imageKey];
  UIImage *image = [UIImage imageWithData:bmpData];
  
  // get the CGImageref
  CGImageRef imageRef = image.CGImage;
  
  // grab some useful data form the image
  NSInteger       bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
  //NSInteger       bitsPerPixel     = CGImageGetBitsPerPixel(imageRef);
  CGBitmapInfo    bitmapInfo       = CGImageGetBitmapInfo(imageRef);
  NSInteger       bytesPerRow      = CGImageGetBytesPerRow(imageRef);
  NSInteger       width            = CGImageGetWidth(imageRef);
  NSInteger       height           = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorspace       = CGImageGetColorSpace(imageRef);
  
  UInt32 *inputPixels = (UInt32*) calloc(width * height,sizeof(UInt32));
  
  CGContextRef context = CGBitmapContextCreate(inputPixels, width, height,
                                               bitsPerComponent, bytesPerRow, colorspace,
                                               bitmapInfo);
  
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  
  BOOL reachedQuestionEnd = NO;
  BOOL reachedAnswerEnd = NO;
  
  // loop number of bytes times, writing 4 two bit values into seperate bytes each time
  NSString *question = @"";
  NSString *realAnswer = @"";
  NSString *message = @"";
  for (NSUInteger j = 0; j < height; j++) {
    for (NSUInteger i = 0; i < width; i++) {
      
      UInt32 * pixel = inputPixels + (j * width) + i;
      UInt32 color = *pixel;
      
      // grab the string bits
      UInt32 rChar = R(color) & 0x3;
      UInt32 gChar = G(color) & 0x3;
      UInt32 bChar = B(color) & 0x3;
      UInt32 aChar = A(color) & 0x3;
      
      // concatenate the string bits to form a byte
      unsigned char newStringByte = (rChar << (6*4)) | (gChar << (4*4)) | (bChar << (2*4)) | (aChar << 0);
      
      if (newStringByte == '~' || newStringByte == '^'){
        
        if (reachedQuestionEnd && ! reachedAnswerEnd) {
          // reached answer end
          reachedAnswerEnd = YES;
        }else if (reachedQuestionEnd && reachedAnswerEnd){
          if (answer != realAnswer){
            return [[NSString alloc]initWithFormat:@"incorrect answer, correct answer is %@",realAnswer];
          }
        }else if (newStringByte == '^'){
          
          CGColorSpaceRelease(colorspace);
          CGContextRelease(context);
          
          return message;
        }
      }
      
      if (newStringByte != '~' && newStringByte != '^' && newStringByte != '$'){
        
        if (!reachedQuestionEnd) {
          
          question = [[NSString alloc] initWithFormat:@"%@%c",question,newStringByte];
          
        }else if (reachedQuestionEnd && ! reachedAnswerEnd) {
          // reached answer end
          realAnswer = [[NSString alloc] initWithFormat:@"%@%c",realAnswer,newStringByte];
          
        }else if (reachedQuestionEnd && reachedAnswerEnd){
          message = [[NSString alloc] initWithFormat:@"%@%c",message,newStringByte];
          
        }
      }
    }
  }
  
  return @"unknown error";
  
}

-(UIImage*) jpegFromBitmap: (NSString*)imageKey {
  
  NSData *bmpData = [[NSUserDefaults standardUserDefaults] objectForKey:imageKey];
  UIImage *image = [UIImage imageWithData:bmpData];
  return image;
  
}

void releaseData(void *info, const void *data, size_t size)
{
  free((void *)data);
}




@end