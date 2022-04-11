//
//  OggDecoder.h
//  
//
//  Created by Arkadiusz Pituła on 10/04/2022.
//

#ifndef OGGDecoder_h
#define OGGDecoder_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OGGDecoder : NSObject
-(BOOL)decode:(NSString*)fileIn into:(NSString*)fileOut;
-(void)decode:(NSString*)fileIn into:(NSString*)fileOut completion:(void (^_Nullable)(BOOL))completion;
@end

NS_ASSUME_NONNULL_END

#endif /* OGGDecoder_h */
