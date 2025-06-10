namespace QuantumEntanglementDemo {
    import Microsoft.Quantum.Diagnostics.*;
    
    /// Demonstrates entanglement correlation by running multiple measurements.
    /// Shows that entangled qubits always have correlated results.
    operation Main() : Unit {
        Message("=== Quantum Entanglement Correlation Demo ===");
        Message("Running entanglement experiment 10 times:");
        Message("");
        
        mutable sameResults = 0;
        mutable zeroCount = 0;
        mutable oneCount = 0;
        
        for i in 1..10 {
            let (result1, result2) = CreateAndMeasureEntangledPair();
            Message($"Trial {i}: Qubit 1 = {result1}, Qubit 2 = {result2}");
            
            // Track statistics
            if result1 == result2 {
                set sameResults += 1;
            }
            if result1 == Zero {
                set zeroCount += 1;
            } else {
                set oneCount += 1;
            }
        }
        
        Message("=== Results Analysis ===");
        Message($"Trials where both qubits measured the same: {sameResults}/10");
        Message($"Times both measured 0: {zeroCount}/10");
        Message($"Times both measured 1: {oneCount}/10");
        Message("");

    }
    
    /// Operation to create and measure an entangled pair
    operation CreateAndMeasureEntangledPair() : (Result, Result) {
        use (q1, q2) = (Qubit(), Qubit());
        
        // Create Bell state: (|00⟩ + |11⟩)/√2
        H(q1);
        CNOT(q1, q2);
        
        // Measure both qubits
        let (m1, m2) = (M(q1), M(q2));
        
        // Reset qubits to |0⟩ (required in Q#)
        Reset(q1);
        Reset(q2);
        
        return (m1, m2);
    }
}