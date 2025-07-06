#!/bin/bash

# Flight Simulator DXB - Build Script for IPA Generation

set -e

# Configuration
PROJECT_NAME="FlightSimulator"
SCHEME_NAME="FlightSimulator"
CONFIGURATION="Release"
ARCHIVE_PATH="./build/FlightSimulator.xcarchive"
IPA_PATH="./build/FlightSimulator.ipa"
EXPORT_OPTIONS_PLIST="./ExportOptions.plist"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🛩️  Flight Simulator DXB - Build Script${NC}"
echo -e "${GREEN}======================================${NC}"

# Check if xcodebuild exists
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}❌ Xcode not found. Install Xcode Command Line Tools.${NC}"
    exit 1
fi

# Create build directory
echo -e "${YELLOW}📁 Creating build directory...${NC}"
mkdir -p build

# Create ExportOptions.plist if missing
if [ ! -f "$EXPORT_OPTIONS_PLIST" ]; then
    echo -e "${YELLOW}📝 Creating ExportOptions.plist...${NC}"
    cat > "$EXPORT_OPTIONS_PLIST" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>teamID</key>
    <string></string>
    <key>compileBitcode</key>
    <false/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>stripSwiftSymbols</key>
    <true/>
    <key>thinning</key>
    <string>&lt;none&gt;</string>
    <key>destination</key>
    <string>export</string>
</dict>
</plist>
EOF
fi

# Clean previous builds
echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
rm -rf ./build/*.xcarchive
rm -rf ./build/*.ipa

# Build and archive
echo -e "${YELLOW}🔨 Building and archiving project...${NC}"

set +e
xcodebuild -project "${PROJECT_NAME}.xcodeproj" \
  -scheme "$SCHEME_NAME" \
  -configuration "$CONFIGURATION" \
  -destination "generic/platform=iOS" \
  -archivePath "$ARCHIVE_PATH" \
  archive \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO | tee xcode.log
RESULT=${PIPESTATUS[0]}
set -e

if [ $RESULT -ne 0 ]; then
  echo -e "${RED}❌ Error: Archive failed. See xcode.log for details.${NC}"
  exit 1
fi

echo -e "${GREEN}✅ Archive created successfully${NC}"

# Export IPA
echo -e "${YELLOW}📦 Exporting IPA...${NC}"
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "./build" \
  -exportOptionsPlist "$EXPORT_OPTIONS_PLIST"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error: IPA export failed${NC}"
    exit 1
fi

# Locate IPA
IPA_FILE=$(find ./build -name "*.ipa" | head -n 1)
if [ -z "$IPA_FILE" ]; then
    echo -e "${RED}❌ Error: IPA file not found${NC}"
    exit 1
fi

# Copy to Downloads
DOWNLOADS_DIR="$HOME/Downloads"
if [ -d "$DOWNLOADS_DIR" ]; then
    echo -e "${YELLOW}📁 Copying IPA to Downloads...${NC}"
    cp "$IPA_FILE" "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa"
    echo -e "${GREEN}✅ Copied to: $DOWNLOADS_DIR/FlightSimulatorDXB.ipa${NC}"
else
    echo -e "${YELLOW}⚠️  Downloads not found, IPA at: $IPA_FILE${NC}"
fi

# Build Summary
echo -e "${GREEN}📊 Build Information:${NC}"
echo "   Project: $PROJECT_NAME"
echo "   Archive: $ARCHIVE_PATH"
echo "   IPA: $IPA_FILE"
if [ -f "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa" ]; then
    echo "   Size: $(du -h "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa" | cut -f1)"
fi

echo -e "${GREEN}🎉 Build completed successfully!${NC}"
