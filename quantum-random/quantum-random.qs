namespace QuantumRandom {
    import Microsoft.Quantum.Measurement.*;
    import Microsoft.Quantum.Convert.*;
    import Microsoft.Quantum.Arrays.*;

    /// Generates a random integer in the range [1, 2^n] using quantum measurement.
    /// Uses n qubits in superposition to create true quantum randomness.
    operation RandomIntGenerator(n : Int) : Int {
        mutable result = 0;
        mutable currentBit = 1;
        
        // Allocate n qubits
        use qubits = Qubit[n];
        
        // Put all qubits in superposition using Hadamard gates
        ApplyToEach(H, qubits);
        
        // Measure each qubit and build binary number
        for i in 0..n-1 {
            let measurement = M(qubits[i]);
            
            // If qubit measures |1⟩, add the corresponding binary value
            // Bit 0 contributes 2^0 = 1, bit 1 contributes 2^1 = 2, etc.
            if measurement == One {
                set result += currentBit;
            }
            
            // Prepare for next bit position
            set currentBit *= 2;
        }
        
        // Reset qubits and return result in range [1, 2^n]
        ResetAll(qubits);
        return result + 1;
    }
    
    /// Demonstrates quantum random number generation.
    /// Generates a random number in the range [1, 1024].
    operation Main() : Int {
        let n = 10; // 2^10 = 1024, so range will be [1, 1024]
        let randomNumber = RandomIntGenerator(n);
        
        Message($"Generated random number: {randomNumber}");
        Message($"Range: [1, {1 <<< n}]"); // 1 <<< n is bit shift for 2^n
        
        return randomNumber;
    }
    

}