namespace QuantumEntanglement {
    import Microsoft.Quantum.Diagnostics.*;
    
    /// Creates and measures an entangled pair of qubits.
    /// Shows the quantum state before measurement and demonstrates correlation.
    operation Main() : (Result, Result) {
        // Allocate two qubits in the |0⟩ state
        use (q1, q2) = (Qubit(), Qubit());
        
        Message("Starting with two qubits in |00⟩ state");
        
        // Step 1: Create superposition on the first qubit
        // H|0⟩ = (|0⟩ + |1⟩)/√2
        H(q1);
        Message("Applied Hadamard to q1 - now in superposition");
        
        // Step 2: Entangle the qubits using CNOT
        // Creates Bell state: (|00⟩ + |11⟩)/√2
        CNOT(q1, q2);
        Message("Applied CNOT - qubits are now entangled!");
        
        // Display the entangled quantum state
        Message("Quantum state before measurement:");
        DumpMachine();
        
        // Step 3: Measure both qubits
        Message("Measuring both qubits:");
        let (m1, m2) = (M(q1), M(q2));
        
        Message($"Results: Qubit 1 = {m1}, Qubit 2 = {m2}");
        
        // Step 4: Reset qubits to |0⟩ (required in Q#)
        Reset(q1);
        Reset(q2);
        
        // Return the correlated measurement results
        return (m1, m2);
    }
}