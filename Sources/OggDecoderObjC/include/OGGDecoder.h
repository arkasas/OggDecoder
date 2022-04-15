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
-(BOOL)decode:(NSURL*)oggFile into:(NSURL*)outputFile;
-(void)decode:(NSURL*)oggFile into:(NSURL*)outputFile completion:(void (^)(BOOL))completion;
-(nullable NSURL*)decode:(NSURL*)oggFile;
-(void)decode:(NSURL*)oggFile completion:(void (^)(NSURL* _Nullable outputFile))completion;
@end

NS_ASSUME_NONNULL_END

#endif /* OGGDecoder_h */
