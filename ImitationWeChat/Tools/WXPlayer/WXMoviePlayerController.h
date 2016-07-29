//
//  WXMovieManager.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/27.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, WXMovieScalingMode) {
    WXMovieScalingModeNone,       // No scaling
    WXMovieScalingModeAspectFit,  // Uniform scale until one dimension fits
    WXMovieScalingModeAspectFill, // Uniform scale until the movie fills the visible bounds. One dimension may have clipped contents
    WXMovieScalingModeFill        // Non-uniform scale. Both render dimensions will exactly match the visible bounds
} NS_DEPRECATED_IOS(2_0, 9_0) __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, WXMoviePlaybackState) {
    WXMoviePlaybackStateStopped,
    WXMoviePlaybackStatePlaying,
    WXMoviePlaybackStatePaused,
    WXMoviePlaybackStateInterrupted,
    WXMoviePlaybackStateSeekingForward,
    WXMoviePlaybackStateSeekingBackward
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

typedef NS_OPTIONS(NSUInteger, WXMovieLoadState) {
    WXMovieLoadStateUnknown        = 0,
    WXMovieLoadStatePlayable       = 1 << 0,
    WXMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    WXMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, WXMovieRepeatMode) {
    WXMovieRepeatModeNone,
    WXMovieRepeatModeOne
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, WXMovieControlStyle) {
    WXMovieControlStyleNone,       // No controls
    WXMovieControlStyleEmbedded,   // Controls for an embedded view
    WXMovieControlStyleFullscreen, // Controls for fullscreen playback
    
    WXMovieControlStyleDefault = WXMovieControlStyleEmbedded
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, WXMovieFinishReason) {
    WXMovieFinishReasonPlaybackEnded,
    WXMovieFinishReasonPlaybackError,
    WXMovieFinishReasonUserExited
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

// -----------------------------------------------------------------------------
// Movie Property Types

typedef NS_OPTIONS(NSUInteger, WXMovieMediaTypeMask) {
    WXMovieMediaTypeMaskNone  = 0,
    WXMovieMediaTypeMaskVideo = 1 << 0,
    WXMovieMediaTypeMaskAudio = 1 << 1
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, WXMovieSourceType) {
    WXMovieSourceTypeUnknown,
    WXMovieSourceTypeFile,     // Local or progressively downloaded network content
    WXMovieSourceTypeStreaming // Live or on-demand streaming content
} NS_DEPRECATED_IOS(3_2, 9_0) __TVOS_PROHIBITED;



@interface WXMoviePlayerController : NSObject

- (instancetype)initWithContentURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy) NSURL *contentURL;

// The view in which the media and playback controls are displayed.
@property (nonatomic, readonly) UIView *view;

// A view for customization which is always displayed behind movie content.
@property (nonatomic, readonly) UIView *backgroundView;

// Returns the current playback state of the movie player.
@property (nonatomic, readonly) WXMoviePlaybackState playbackState;

// Returns the network load state of the movie player.
@property (nonatomic, readonly) WXMovieLoadState loadState;

// The style of the playback controls. Defaults to WXMovieControlStyleDefault.
@property (nonatomic) WXMovieControlStyle controlStyle;

// Determines how the movie player repeats when reaching the end of playback. Defaults to WXMovieRepeatModeNone.
@property (nonatomic) WXMovieRepeatMode repeatMode;

// Indicates if a movie should automatically start playback when it is likely to finish uninterrupted based on e.g. network conditions. Defaults to YES.
@property (nonatomic) BOOL shouldAutoplay;

// Determines if the movie is presented in the entire screen (obscuring all other application content). Default is NO.
// Setting this property to YES before the movie player's view is visible will have no effect.
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;
- (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated;

// Determines how the content scales to fit the view. Defaults to WXMovieScalingModeAspectFit.
@property (nonatomic) WXMovieScalingMode scalingMode;

// Returns YES if the first video frame has been made ready for display for the current item.
// Will remain NO for items that do not have video tracks associated.
@property (nonatomic, readonly) BOOL readyForDisplay NS_AVAILABLE_IOS(6_0);


@end
