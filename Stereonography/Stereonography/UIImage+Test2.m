//
//  UIImage+Test2.m
//  Stereonography
//
//  Created by Odin on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

#import "UIImage+Test2.h"


@interface UIImage (BitmapData)
- (NSData *)bitmapData;
- (NSData *)bitmapFileHeaderData;
- (NSData *)bitmapDataWithFileHeader;
@end



# pragma pack(push, 1)
typedef struct s_bitmap_header
{
  // Bitmap file header
  UInt16 fileType;
  UInt32 fileSize;
  UInt16 reserved1;
  UInt16 reserved2;
  UInt32 bitmapOffset;
  
  // DIB Header
  UInt32 headerSize;
  UInt32 width;
  UInt32 height;
  UInt16 colorPlanes;
  UInt16 bitsPerPixel;
  UInt32 compression;
  UInt32 bitmapSize;
  UInt32 horizontalResolution;
  UInt32 verticalResolution;
  UInt32 colorsUsed;
  UInt32 colorsImportant;
} t_bitmap_header;
#pragma pack(pop)

@implementation UIImage (BitmapData)

- (NSData *)bitmapData
{
  NSData          *bitmapData = nil;
  CGImageRef      image = self.CGImage;
  CGContextRef    context = NULL;
  CGColorSpaceRef colorSpace;
  UInt8           *rawData;
  
  size_t bitsPerPixel = 32;
  size_t bitsPerComponent = 8;
  size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
  
  size_t width = CGImageGetWidth(image);
  size_t height = CGImageGetHeight(image);
  
  size_t bytesPerRow = width * bytesPerPixel;
  size_t bufferLength = bytesPerRow * height;
  
  colorSpace = CGColorSpaceCreateDeviceRGB();
  
  if (colorSpace)
  {
    // Allocate memory for raw image data
    rawData = (UInt8 *)calloc(bufferLength, sizeof(UInt8));
    
    if (rawData)
    {
      CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst;
      context = CGBitmapContextCreate(rawData,
                                      width,
                                      height,
                                      bitsPerComponent,
                                      bytesPerRow,
                                      colorSpace,
                                      bitmapInfo);
      
      if (context)
      {
        CGRect rect = CGRectMake(0, 0, width, height);
        
        CGContextTranslateCTM(context, 0, height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, rect, image);
        
        bitmapData = [NSData dataWithBytes:rawData length:bufferLength];
        
        CGContextRelease(context);
      }
      
      free(rawData);
    }
    
    CGColorSpaceRelease(colorSpace);
  }
  
  return bitmapData;
}

- (NSData *)bitmapFileHeaderData
{
  CGImageRef image = self.CGImage;
  UInt32     width = (UInt32)CGImageGetWidth(image);
  UInt32     height = (UInt32)CGImageGetHeight(image);
  
  t_bitmap_header header;
  
  header.fileType = 0x4D42;
  header.fileSize = (height * width * 4) + 54;
  header.reserved1 = 0x0000;
  header.reserved2 = 0x0000;
  header.bitmapOffset = 0x00000036;
  header.headerSize = 0x00000028;
  header.width = width;
  header.height = height;
  header.colorPlanes = 0x0001;
  header.bitsPerPixel = 0x0020;
  header.compression = 0x00000000;
  header.bitmapSize = height * width * 4;
  header.horizontalResolution = 0x00000B13;
  header.verticalResolution = 0x00000B13;
  header.colorsUsed = 0x00000000;
  header.colorsImportant = 0x00000000;
  
  return [NSData dataWithBytes:&header length:sizeof(t_bitmap_header)];
}

- (NSData *)bitmapDataWithFileHeader
{
  NSMutableData *data = [NSMutableData dataWithData:[self bitmapFileHeaderData]];
  [data appendData:[self bitmapData]];
  
  return [NSData dataWithData:data];
}

@end

