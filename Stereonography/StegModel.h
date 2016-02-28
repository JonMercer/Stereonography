//
//  StegModel.h
//  Stereonography
//
//  Created by Odin on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

#import <Foundation/Foundation.h>

@interface StegModel : NSObject

-(BOOL) encryptWithQuestion:(NSString*)question  andAnswer:(NSString*)answer andMessage:(NSString*)message andImageKey:(NSString *)imageKey;

-(NSString*) decryptImageQuestion: (NSString*)imageKey;
-(NSString*) attemptToDecryptImageMessageWithAnswerKey: (NSString*)answer;

@end
