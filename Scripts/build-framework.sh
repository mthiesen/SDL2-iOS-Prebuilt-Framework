#!/bin/sh

TMP_BUILD_DIR=$(mktemp -d -t SDL-iOS)
SRC_PROJECT="../Source/SDL2/Xcode-iOS/SDL/SDL.xcodeproj"
SRC_HEADERS_DIR="../Source/SDL2/include"
TMP_FRAMEWORK_DIR="$TMP_BUILD_DIR/SDL2.framework"
OUTPUT_DIR="../Framework"

function cleanup {
 	rm -rf "$TMP_BUILD_DIR"
}
trap cleanup EXIT

# Build fat library
xcrun xcodebuild -project "$SRC_PROJECT" -target libSDL -sdk iphoneos -configuration Release clean build CONFIGURATION_BUILD_DIR="$TMP_BUILD_DIR/iphoneos"
xcrun xcodebuild -project "$SRC_PROJECT" -target libSDL -sdk iphonesimulator -configuration Release clean build CONFIGURATION_BUILD_DIR="$TMP_BUILD_DIR/iphonesimulator"
xcrun lipo -create "$TMP_BUILD_DIR/iphoneos/libSDL2.a" "$TMP_BUILD_DIR/iphonesimulator/libSDL2.a" -output "$TMP_BUILD_DIR/libSDL2.a"

# Create the framework
mkdir -p "$TMP_FRAMEWORK_DIR"
mkdir -p "$TMP_FRAMEWORK_DIR/Versions/A/Headers"
cp "$TMP_BUILD_DIR/libSDL2.a" "$TMP_FRAMEWORK_DIR/Versions/A/SDL2"
cp "$SRC_HEADERS_DIR/"*.h "$TMP_FRAMEWORK_DIR/Versions/A/Headers"
ln -s "A" "$TMP_FRAMEWORK_DIR/Versions/Current"
ln -s "Versions/Current/Headers" "$TMP_FRAMEWORK_DIR/Headers"
ln -s "Versions/Current/SDL2" "$TMP_FRAMEWORK_DIR/SDL2"

# Copy the framework to its final target location
rm -rf $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
cp -R $TMP_FRAMEWORK_DIR $OUTPUT_DIR
