object "Proxy" {
	// deployment code
	code {
		let size := datasize("runtime")
		datacopy(0, dataoffset("runtime"), size)
		return(0, size)
	}
	object "runtime" {
		// deployed code
		code {
			calldatacopy(0, 0, calldatasize())
			let result := create2(callvalue(), 0, calldatasize(), 0)
			if iszero(result) {
				mstore(0, "create2 failed")
				revert(0, 14)
			}
			mstore(0, result)
			return(12, 20)
		}
	}
}
