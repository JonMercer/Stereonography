//
//  StegModel.h
//  Stereonography
//
//  Created by Odin on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

/*
 *
 *This file was created by Omar
 *
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StegModel : NSObject

-(NSString*) encryptWithQuestion:(NSString*)question  andAnswer:(NSString*)answer andMessage:(NSString*)message andImageKey:(NSString *)imageKey;

-(NSString*) decryptImageQuestion: (UIImage*)image;
-(NSString*) attemptToDecryptImageMessageWithAnswerKey: (NSString*)answer andImgKey:(NSString*)imageKey;
-(UIImage*) jpegFromBitmap: (NSString*)imageKey;


@end
