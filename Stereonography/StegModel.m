//
//  StegModel.m
//  Stereonography
//
//  Created by Odin on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

#import "StegModel.h"


@implementation StegModel


-(BOOL) encryptWithQuestion:(NSString*)question  andAnswer:(NSString*)answer andMessage:(NSString*)message andImageKey:(NSString *)imageKey {
  
  return true;
  
}

-(NSString*) decryptImageQuestion: (NSString*)imageKey {
  return @"THis is a question???";
}

-(NSString*) attemptToDecryptImageMessageWithAnswerKey: (NSString*)answer{
  return @"THis is The message";
}

-(UIImage*) jpegFromBitmap: (NSString*)imageKey {
  return [UIImage imageNamed:@"IMG_1086"];
}



@end
