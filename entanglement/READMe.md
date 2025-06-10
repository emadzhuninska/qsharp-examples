# Quantum Entanglement Examples

This folder contains Q# examples demonstrating quantum entanglement - the phenomenon where two qubits become correlated so that measuring one instantly determines the state of the other.

## What This Demonstrates

These examples create **Bell states**, which are maximally entangled two-qubit states:

|Ψ⟩ = (|00⟩ + |11⟩)/√2

The qubits are in superposition where they're either both |0⟩ or both |1⟩ with equal probability, but always correlated.

## Files

### `entanglement-single.qs`
Shows the step-by-step entanglement process:
- Creates superposition with Hadamard gate
- Entangles qubits with CNOT gate  
- Displays quantum state before measurement
- Measures both qubits (always same result)

### `entanglement-demo.qs`
Runs multiple trials to demonstrate correlation:
- Performs 10 independent measurements
- Shows statistics proving 100% correlation
- Demonstrates randomness of individual results

## Expected Results

**Single measurement:** Both qubits always measure the same (both 0 or both 1)

**Demo:** 10 trials showing perfect correlation, roughly 50/50 split between (0,0) and (1,1) outcomes
