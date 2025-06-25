// GHZ State Operations
// Demonstrates creation and measurement of GHZ (Greenberger-Horne-Zeilinger) states
// Shows how different measurement bases affect quantum entanglement collapse
//
// GHZ state: |GHZ⟩ = (|000⟩ + |111⟩)/√2
// This is a maximally entangled state of three qubits

namespace GHZState {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;

    /// Create a GHZ state and measure all three qubits in the Z basis.
    /// This demonstrates the basic GHZ state creation and measurement.
    /// The output is a tuple of three measurement results from the three qubits.
    operation CreateAndMeasureGHZ() : (Result, Result, Result) {
        use qb = Qubit[3];

        // Create GHZ state: |000⟩ + |111⟩
        H(qb[0]);
        CNOT(qb[0], qb[1]);
        CNOT(qb[0], qb[2]);

        DumpMachine();

        // Measure all qubits in Z basis
        let (m1, m2, m3) = (M(qb[0]), M(qb[1]), M(qb[2]));

        ResetAll(qb);
        return (m1, m2, m3); 
    }

    /// Create a GHZ state and measure the third qubit in the Z basis.
    /// This causes the entangled state to collapse into either |000⟩ or |111⟩.
    /// The output is a tuple containing (ancilla measurement, first qubit, second qubit).
    operation MeasureThirdQubitInZBasis() : (Result, Result, Result) {
        use qb = Qubit[3];

        // Create GHZ state
        H(qb[0]);
        CNOT(qb[0], qb[1]);
        CNOT(qb[0], qb[2]);
        
        Message("GHZ state before measurement:");
        DumpMachine();

        // Measure the 3rd qubit in the Z basis (direct measurement)
        let ancillaMeasurement = M(qb[2]);

        Message("State after measuring third qubit in Z basis:");
        DumpMachine();

        // Measure the remaining qubits - they should be in the same state (00 or 11)
        let (m1, m2) = (M(qb[0]), M(qb[1]));

        ResetAll(qb);
        return (ancillaMeasurement, m1, m2); 
    }

    /// Create a GHZ state and measure the third qubit in the X basis.
    /// This results in the remaining two qubits forming a Bell state (|φ⁺⟩ or |φ⁻⟩).
    /// The output is tuple containing the ancilla measurement, the first qubit, and the second qubit.
    operation MeasureThirdQubitInXBasis() : (Result, Result, Result) {
        use qb = Qubit[3];

        // Create GHZ state
        H(qb[0]);
        CNOT(qb[0], qb[1]);
        CNOT(qb[0], qb[2]);
        
        Message("GHZ state before X-basis measurement:");
        DumpMachine();

        // Measure the 3rd qubit in the X basis
        H(qb[2]); // Transform to X basis before measurement
        let ancillaMeasurement = M(qb[2]);

        // Apply phase correction if measurement result is One
        // This ensures the remaining qubits form the correct Bell state
        if (ancillaMeasurement == One) {
            Z(qb[0]); // Phase flip to correct the Bell state
        }

        Message("State after X-basis measurement and phase correction:");
        DumpMachine();

        // Measure the remaining qubits - they form a Bell state (|φ⁺⟩ or |φ⁻⟩)
        let (m1, m2) = (M(qb[0]), M(qb[1]));

        ResetAll(qb);
        return (ancillaMeasurement, m1, m2); 
    }

    @EntryPoint()
    operation Main() : Unit {

        Message("1. Creating GHZ state and measuring all qubits in Z basis:");
        let (r1, r2, r3) = CreateAndMeasureGHZ();
        Message($"   Results: Qubit 0: {r1}, Qubit 1: {r2}, Qubit 2: {r3}");
        Message("");

        Message("2. Measuring third qubit in Z basis (collapses to separable state):");
        let (ancilla1, m1, m2) = MeasureThirdQubitInZBasis();
        Message($"   Third qubit: {ancilla1}, Remaining qubits: {m1}, {m2}");
        Message("");

        Message("3. Measuring third qubit in X basis (remaining form Bell state):");
        let (ancilla2, m3, m4) = MeasureThirdQubitInXBasis();
        Message($"   Third qubit: {ancilla2}, Remaining qubits: {m3}, {m4}");
    }
}