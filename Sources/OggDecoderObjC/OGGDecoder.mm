//
//  OggDecoder.m
//  
//
//  Created by Arkadiusz Pituła on 10/04/2022.
//

#import <Foundation/Foundation.h>
#import "oggHelper.h"
#import "OGGDecoder.h"

@implementation OGGDecoder

- (BOOL)decode:(NSString *)fileIn into:(NSString *)fileOut {
    oggHelper helper;
    const char *fileInChar = [fileIn cStringUsingEncoding:NSASCIIStringEncoding];
    const char *fileOutChar = [fileOut cStringUsingEncoding:NSASCIIStringEncoding];

    int output = helper.decode(fileInChar, fileOutChar);
    return output == 1;
}

- (void)decode:(NSString *)fileIn into:(NSString *)fileOut completion:(void (^ __nullable)(BOOL))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL result = [self decode:fileIn into:fileOut];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completion(result);
        });
    });
}

@end
