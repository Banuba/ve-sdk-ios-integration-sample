#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>

typedef NS_ENUM(NSUInteger, EPOrientation) {
    EPOrientationAngles0,
    EPOrientationAngles90,
    EPOrientationAngles180,
    EPOrientationAngles270

};


typedef struct
{
    CGSize cameraSize;
    CGSize screenSize;
    EPOrientation orientation;
    BOOL isMirrored;
    BOOL isYFlip; // if false, (0,0) in bottom left, else in top left
} EpImageFormat;

/**
 * Все методы должны вызываться из одного и того же потока
 * (в котором был создан объектBNBOffscreenEffectPlayer)
 * Все методы синхронные
 *
 * WARNING: SDK should be initialized with BNBUtilityManager before BNBOfscreenEffectPlayer creating
 */
@interface BNBOffscreenEffectPlayer : NSObject

/*
 * effectWidth andHeight размер внутреней области, в которую рисуется эфект
 */
- (instancetype _Nonnull)initWithEffectWidth:(NSUInteger)width
                                   andHeight:(NSUInteger)height
                                 manualAudio:(BOOL)manual;

/*
* EpImageFormat::cameraSize - размер входной RGBA картинки
* EpImageFormat::screenSize не используется
* размер выходной картинки равен размеру внутреней области, в которую рисуется эффект
*/
- (NSData* _Nonnull)processImage:(NSData* _Nonnull)inputRgba
                      withFormat:(EpImageFormat* _Nonnull)imageFormat;

/*
* EpImageFormat::cameraSize - размер входной Y картинки
* EpImageFormat::screenSize не используется
* размер выходной картинки равен размеру внутреней области, в которую рисуется эффект
*/
- (nullable CVPixelBufferRef)processY:(NSData* _Nullable)inputY andUV:(NSData* _Nonnull)inputUV
                           withFormat:(EpImageFormat* _Nonnull)imageFormat;

- (void)loadEffect:(NSString* _Nonnull)effectName;
- (void)unloadEffect;

/*
 *pause/resume управляет только проигрыванием аудио
 */
- (void)pause;
- (void)resume;

/*
 * When you use EffectPlayer with CallKit you should enable audio manually at the point when CallKit
 * notifies that its Audio Session is ready (its session is created in privileged mode, so it should be respected).
 */
- (void)enableAudio:(BOOL)enable;

- (void)callJsMethod:(NSString* _Nonnull)method withParam:(NSString* _Nonnull)param;

@end
