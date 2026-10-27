# Test layout

`test_container_contract.sh` exercises the published application boundary
after an image has been built: CLI help must expose the required inputs and a
missing staged input must fail. The complementary `container/smoke_test.sh`
and `container/parity_test.sh` cover the successful synthetic run and
canonical-versus-standalone scientific output parity.

Run the contract test against a local image with:

```bash
tests/test_container_contract.sh gsva-analysis:local
```
