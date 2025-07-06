# Flight Simulator DXB ✈️

A realistic flight simulator app for iPadOS featuring Dubai International Airport (DXB) with AI-powered Air Traffic Control.

## Features 🌟

### Aircraft Selection
- **Airbus A350** - Modern wide-body twin-engine
- **Airbus A380** - World's largest passenger airliner
- **Boeing 777** - Long-range wide-body twin-engine
- **Boeing 737** - Popular narrow-body twin-engine
- **Airbus A320** - Narrow-body short to medium-range

### Realistic Simulation
- **Accurate Aircraft Models** - Realistic 3D models with proper specifications
- **DXB Airport Environment** - Detailed recreation of Dubai International Airport
- **Realistic Flight Physics** - Accurate aerodynamics, engine performance, and flight dynamics
- **Working Cockpit Systems** - Functional instruments, displays, and controls
- **Weather Simulation** - Dynamic weather conditions affecting flight

### AI Air Traffic Control
- **Voice Recognition** - Speak to ATC using your device's microphone
- **Text Communication** - Type messages to ATC for silent operation
- **Realistic Phraseology** - Professional aviation communication using Gemini AI
- **Dynamic Responses** - Context-aware ATC instructions based on flight phase

### Advanced Systems
- **Realistic Cockpit** - Different layouts for Airbus (ECAM) and Boeing (EICAS) aircraft
- **Engine Management** - Detailed engine parameters (N1, N2, EGT, fuel flow)
- **Flight Instruments** - Primary Flight Display (PFD) and Navigation Display (ND)
- **System Monitoring** - Hydraulics, electrical, fuel, and other aircraft systems

## Requirements 📱

- **Device**: iPad with iPadOS 17.0 or later
- **Storage**: Minimum 2GB free space
- **Network**: Internet connection for AI ATC functionality
- **Permissions**: Microphone access for voice communication with ATC

## Installation 🔧

### Build from Source

1. **Prerequisites**:
   - macOS with Xcode 15.0 or later
   - iOS Developer Account (free or paid)
   - iPad connected to your Mac

2. **Build the App**:
   ```bash
   # Make the build script executable
   chmod +x build_ipa.sh
   
   # Run the build script
   ./build_ipa.sh
   ```

3. **Install on iPad**:
   - The IPA file will be automatically copied to your Downloads folder
   - Connect your iPad to your Mac
   - Open Finder (macOS Catalina+) or iTunes
   - Drag and drop `FlightSimulatorDXB.ipa` to your iPad
   - Trust the developer certificate in Settings > General > Device Management

## Getting Started 🚀

### First Launch
1. Launch the app and select your preferred aircraft
2. Grant microphone permissions for ATC communication
3. The app will load the DXB airport environment

### Basic Flight Operations

#### Pre-Flight
1. **Aircraft Selection** - Choose from 5 realistic aircraft types
2. **Systems Check** - Verify all systems are operational
3. **Weather Review** - Check current weather conditions at DXB

#### Engine Start
1. Open the cockpit view
2. Use the engine control panel to start engines
3. Monitor engine parameters (N1, N2, EGT)
4. Wait for engines to reach idle power

#### ATC Communication
1. **Voice**: Tap the microphone button and speak clearly
2. **Text**: Type your message in the ATC panel
3. **Quick Actions**: Use preset ATC requests for common operations

#### Taxi and Takeoff
1. Request taxi clearance from ATC
2. Use flight controls to taxi to the runway
3. Request takeoff clearance
4. Apply full power and rotate at V1 speed

### Controls 🎮

#### Flight Controls
- **Pitch**: Up/down elevator control
- **Roll**: Left/right aileron control  
- **Yaw**: Rudder control for ground steering
- **Throttles**: Individual engine power control
- **Flaps**: Adjustable from 0° to 40°
- **Landing Gear**: Retractable gear system

#### Camera Views
- **External**: Third-person view of aircraft
- **Cockpit**: First-person pilot view
- **Tower**: ATC tower perspective

#### Systems
- **Autopilot**: Automated flight control
- **Lights**: Navigation and landing lights
- **Brakes**: Wheel brakes for ground operations

## Aircraft Specifications 📊

| Aircraft | Max Speed | Range | Engines | Passengers |
|----------|-----------|-------|---------|------------|
| A350     | 903 km/h  | 15,000 km | 2 | 440 |
| A380     | 945 km/h  | 15,200 km | 4 | 853 |
| B777     | 950 km/h  | 17,370 km | 2 | 396 |
| B737     | 876 km/h  | 6,570 km  | 2 | 189 |
| A320     | 871 km/h  | 6,150 km  | 2 | 180 |

## DXB Airport Information 🏢

### Runways
- **12L/30R**: 4,000m x 60m - ILS equipped
- **12R/30L**: 4,000m x 60m - ILS equipped

### Terminals
- **Terminal 1**: 20 gates, 15M passengers/year
- **Terminal 2**: 18 gates, 12M passengers/year  
- **Terminal 3**: 180 gates, 75M passengers/year
- **Concourses A, B, C**: Additional gate capacity

### ATC Frequencies
- **Dubai Tower**: 118.7 MHz
- **Dubai Ground**: 121.9 MHz
- **Dubai Departure**: 119.1 MHz

## Troubleshooting 🔧

### Common Issues

**App Won't Install**
- Ensure your iPad is running iPadOS 17.0 or later
- Check that you have sufficient storage space
- Verify the developer certificate is trusted

**ATC Not Responding**
- Check internet connection
- Verify microphone permissions are granted
- Try using text input instead of voice

**Poor Performance**
- Close other apps running in background
- Restart the app
- Lower graphics quality in settings

**Audio Issues**
- Check device volume settings
- Ensure ATC audio is enabled in settings
- Try using headphones for better audio quality

## Technical Details 🔧

### Built With
- **SwiftUI** - Modern iOS user interface framework
- **SceneKit** - 3D graphics and animation
- **AVFoundation** - Audio recording and playback
- **Speech Framework** - Voice recognition
- **Gemini AI** - Intelligent ATC responses

### Performance Optimization
- Optimized 3D models for iPad hardware
- Efficient physics calculations at 60 FPS
- Dynamic level-of-detail for distant objects
- Intelligent memory management

### Privacy & Security
- Microphone data is processed locally when possible
- ATC communications use secure HTTPS connections
- No personal data is stored or transmitted
- Speech recognition respects user privacy settings

## Credits 👥

### Development Team
- Flight simulation engine and physics
- 3D modeling and graphics
- AI integration and ATC system
- User interface and experience design

### Special Thanks
- Dubai International Airport for inspiration
- Aviation community for technical expertise
- Beta testers for feedback and improvements

## License 📄

This flight simulator is created for educational and entertainment purposes. Aircraft specifications and airport layouts are based on publicly available information.

**Disclaimer**: This is a simulation and should not be used for actual flight training or navigation purposes.

---

**Enjoy your flight! ✈️**

*Experience the thrill of realistic flight simulation from one of the world's busiest airports - Dubai International (DXB).* 