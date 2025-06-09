// This Q# program demonstrates the creation and measurement of all four Bell states,
// which form the maximally entangled two-qubit basis states.

import Microsoft.Quantum.Diagnostics.*;

// Create and measure the |Φ+⟩ Bell state: (|00⟩ + |11⟩)/√2
operation PhiPlus() : (Result, Result) {
    use qb = Qubit[2];
    
    // Create superposition and entanglement
    H(qb[0]);
    CNOT(qb[0], qb[1]);
    
    Message("Bell State |Φ+⟩ = (|00⟩ + |11⟩)/√2");
    DumpMachine();
    
    let results = (M(qb[0]), M(qb[1]));
    Message($"Measurement results: {results}");
    
    ResetAll(qb);
    return results;
}

// Create and measure the |Φ-⟩ Bell state: (|00⟩ - |11⟩)/√2
operation PhiMinus() : (Result, Result) {
    use qb = Qubit[2];
    
    // Apply phase flip before creating superposition
    H(qb[0]);
    Z(qb[0]);
    CNOT(qb[0], qb[1]);
    
    Message("Bell State |Φ-⟩ = (|00⟩ - |11⟩)/√2");
    DumpMachine();
    
    let results = (M(qb[0]), M(qb[1]));
    Message($"Measurement results: {results}");
    
    ResetAll(qb);
    return results;
}

// Create and measure the |Ψ+⟩ Bell state: (|01⟩ + |10⟩)/√2
operation PsiPlus() : (Result, Result) {
    use qb = Qubit[2];
    
    // Apply a bit-flip to the second qubit, then create entanglement
    H(qb[0]);
    X(qb[1]);
    CNOT(qb[0], qb[1]);
    
    Message("Bell State |Ψ+⟩ = (|01⟩ + |10⟩)/√2");
    DumpMachine();
    
    let results = (M(qb[0]), M(qb[1]));
    Message($"Measurement results: {results}");
    
    ResetAll(qb);
    return results;
}

// Create and measure the |Ψ-⟩ Bell state: (|01⟩ - |10⟩)/√2
operation PsiMinus() : (Result, Result) {
    use qb = Qubit[2];
    
    // Prepare initial state and apply phase operations
    H(qb[0]);
    X(qb[1]);
    Z(qb[0]);
    CNOT(qb[0], qb[1]);
    
    Message("Bell State |Ψ-⟩ = (|01⟩ - |10⟩)/√2");
    DumpMachine();
    
    let results = (M(qb[0]), M(qb[1]));
    Message($"Measurement results: {results}");
    
    ResetAll(qb);
    return results;
}

// Main operation that demonstrates all four Bell states
operation Main() : Unit {
    Message("=== Bell States ===\n");
    
    Message("1. |Φ+⟩ state:");
    let _ = PhiPlus();
    Message("");
    
    Message("2. |Φ-⟩ state:");
    let _ = PhiMinus();
    Message("");
    
    Message("3. |Ψ+⟩ state:");
    let _ = PsiPlus();
    Message("");
    
    Message("4. |Ψ-⟩ state:");
    let _ = PsiMinus();
    
}