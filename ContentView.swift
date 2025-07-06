import SwiftUI

struct ContentView: View {
    @State private var showAircraftSelection = true
    @State private var selectedAircraft: AircraftType?
    @StateObject private var aircraft = Aircraft(type: .a350)
    @StateObject private var airport = DXBAirport()
    @StateObject private var atcManager = ATCManager()
    @StateObject private var flightPhysics = FlightPhysics(aircraft: Aircraft(type: .a350))
    
    var body: some View {
        GeometryReader { geometry in
            if showAircraftSelection {
                AircraftSelectionView(
                    selectedAircraft: $selectedAircraft,
                    onAircraftSelected: { aircraftType in
                        selectedAircraft = aircraftType
                        setupSimulation(with: aircraftType)
                        showAircraftSelection = false
                    }
                )
            } else {
                FlightSimulatorView(
                    aircraft: aircraft,
                    airport: airport,
                    atcManager: atcManager,
                    flightPhysics: flightPhysics
                )
            }
        }
        .preferredColorScheme(.dark)
        .statusBarHidden()
    }
    
    private func setupSimulation(with aircraftType: AircraftType) {
        // Create new aircraft instance
        let newAircraft = Aircraft(type: aircraftType)
        aircraft.type = newAircraft.type
        aircraft.engineThrust = newAircraft.engineThrust
        aircraft.fuelRemaining = newAircraft.fuelRemaining
        aircraft.weight = newAircraft.weight
        
        // Setup flight physics
        flightPhysics.aircraft = aircraft
        
        // Setup ATC
        atcManager.setAircraft(aircraft)
        atcManager.setAirport(airport)
        
        // Position aircraft at DXB gate
        aircraft.position = SCNVector3(0, 0, -800) // At terminal
        aircraft.altitude = 0
        aircraft.heading = 120 // Aligned with runway
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
} 