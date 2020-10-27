#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#if __has_include(<BNBCameraOrientation.h>)
    #import <BNBCameraOrientation.h>
#else
    #import <BanubaEffectPlayer/BNBCameraOrientation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BNBFullImageData : NSObject

- (instancetype)init:(CVPixelBufferRef)buffer
    cameraOrientation:(BNBCameraOrientation)cameraOrientation
     requireMirroring:(BOOL)requireMirroring
      faceOrientation:(NSInteger)faceOrientation;

@property(nonatomic, readonly) uint32_t width;
@property(nonatomic, readonly) uint32_t height;
@property(nonatomic, readonly) BNBCameraOrientation cameraOrientation;
@property(nonatomic, readonly) BOOL requireMirroring;
@property(nonatomic, readonly) int faceOrientation;

@property(nonatomic, readonly) __nullable CVPixelBufferRef pixelBuffer;

@end

NS_ASSUME_NONNULL_END
