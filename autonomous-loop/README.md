# autonomous-loop

- init

```
根据以下的目标更新 `.agents/loop/state.md`

- 解决 `python/tta-ut/` 下测试中的问题, 测试的 目标 kernels 是 `third_party/triton-ascend/third_party/ascend/unittest/pytest_ut`
- 查看 `python/tta-ut/setup.sh` 完成配置, 目前已经配置好, 不需要重复操作
- `bash python/tta-ut/pytest.sh` 会测试所有支持的 tests, 但是目前会异常导致卡住, 谨慎使用, 一份中断的 测试log 见 `debug/tmp-0/pytest.log`, 运行时默认中间ir和log的输出目录是 `debug/tmp`
- `bash python/tta-ut/pytest_one.sh` 用来debug 单一的 test, 需要根据这个脚本作为模版更新测试文件, 获得的 ir-dump和log 默认在 `debug/tmp-pytest_one` 目录, 可以用来作为 debug 的参考
- `python/tta-ut/conftest.py` 和 `python/tta-ut/torch_npu.py` 用来支持测试, 跳过的测试文件目前不需要考虑
```

- loop

```bash
count=1
max=50
log=debug_agent/loop_exec.log
# edit `.agents/loop/state.md`
while [ $count -le $max ]; do
  echo "--- $(date) : Starting codex iteration $count / $max ---" | tee -a $log
  codex --yolo exec "$(<.agents/loop/loop.md)" 2>&1 | tee -a $log
  ((count++))
  sleep 20
done
```
