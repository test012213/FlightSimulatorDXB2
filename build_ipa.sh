#!/bin/bash

# Flight Simulator DXB - Build Script for IPA Generation
# This script builds the iOS app and creates an IPA file for distribution

set -e

# Configuration
PROJECT_NAME="FlightSimulator"
SCHEME_NAME="FlightSimulator"
CONFIGURATION="Release"
ARCHIVE_PATH="./build/FlightSimulator.xcarchive"
IPA_PATH="./build/FlightSimulator.ipa"
EXPORT_OPTIONS_PLIST="./ExportOptions.plist"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🛩️  Flight Simulator DXB - Build Script${NC}"
echo -e "${GREEN}======================================${NC}"

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}❌ Error: Xcode command line tools are not installed${NC}"
    echo "Please install Xcode and the command line tools first."
    exit 1
fi

# Create build directory
echo -e "${YELLOW}📁 Creating build directory...${NC}"
mkdir -p build

# Create ExportOptions.plist if it doesn't exist
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

# Build and archive the project
echo -e "${YELLOW}🔨 Building and archiving project...${NC}"
xcodebuild -project "${PROJECT_NAME}.xcodeproj" \
           -scheme "$SCHEME_NAME" \
           -configuration "$CONFIGURATION" \
           -destination "generic/platform=iOS" \
           -archivePath "$ARCHIVE_PATH" \
           archive \
           CODE_SIGN_IDENTITY="" \
           CODE_SIGNING_REQUIRED=NO \
           CODE_SIGNING_ALLOWED=NO

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error: Archive failed${NC}"
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

# Find the generated IPA file
IPA_FILE=$(find ./build -name "*.ipa" | head -n 1)

if [ -z "$IPA_FILE" ]; then
    echo -e "${RED}❌ Error: IPA file not found${NC}"
    exit 1
fi

# Move IPA to Downloads folder if it exists
DOWNLOADS_DIR="$HOME/Downloads"
if [ -d "$DOWNLOADS_DIR" ]; then
    echo -e "${YELLOW}📁 Copying IPA to Downloads folder...${NC}"
    cp "$IPA_FILE" "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa"
    echo -e "${GREEN}✅ IPA copied to: $DOWNLOADS_DIR/FlightSimulatorDXB.ipa${NC}"
else
    echo -e "${YELLOW}⚠️  Downloads folder not found, IPA available at: $IPA_FILE${NC}"
fi

# Display file information
echo -e "${GREEN}📊 Build Information:${NC}"
echo "   Project: $PROJECT_NAME"
echo "   Configuration: $CONFIGURATION"
echo "   Archive: $ARCHIVE_PATH"
echo "   IPA: $IPA_FILE"

if [ -f "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa" ]; then
    IPA_SIZE=$(du -h "$DOWNLOADS_DIR/FlightSimulatorDXB.ipa" | cut -f1)
    echo "   Size: $IPA_SIZE"
fi

echo -e "${GREEN}🎉 Build completed successfully!${NC}"
echo -e "${GREEN}🛩️  Your Flight Simulator DXB app is ready for installation!${NC}"

# Instructions for installation
echo ""
echo -e "${YELLOW}📱 Installation Instructions:${NC}"
echo "1. Connect your iPad to your computer"
echo "2. Open Finder (macOS Catalina+) or iTunes (older versions)"
echo "3. Select your iPad device"
echo "4. Drag and drop the FlightSimulatorDXB.ipa file to install"
echo "5. Trust the developer certificate in Settings > General > Device Management"
echo ""
echo -e "${GREEN}Enjoy your realistic flight simulation experience at Dubai International Airport!${NC}" 